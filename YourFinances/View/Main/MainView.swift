//
//  MainView.swift
//  YourFinances
//
//  Created by Максим Боталов on 14.12.2022.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - СВОЙСТВА
    @ObservedObject var viewModel = FinancesViewModel()
    @State private var isPresentedNewExpense = false
    @State private var isPresentedNewCategoryView = false
    @State private var isSetShow = false
    
    // MARK: - ТЕЛО
    var body: some View {
        allView()
    }
    
    // MARK: - ФУНКЦИИ && UI
    
    // MARK: Операции
    private func operations(for array: [FinancesModel]) -> some View {
        ForEach(array) { item in
            MainOperationCell(viewModel: viewModel, item: item)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 16)
        }
    }
    
    // MARK: ScrollView и логика
    private func scrollViewAndLogic() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            if !viewModel.currentExpenseArray.isEmpty {
                Section(header: HerderView(text: Localizable.expenses, for: viewModel.currentExpenseArray)) {
                    operations(for: viewModel.currentExpenseArray)
                }
            }
            
            if !viewModel.currentProfitsArray.isEmpty {
                Section(header: HerderView(text: Localizable.profits, for: viewModel.currentProfitsArray)) {
                    operations(for: viewModel.currentProfitsArray)
                }
            }
            
            if viewModel.currentExpenseArray.isEmpty && viewModel.currentProfitsArray.isEmpty {
                NoOperationsView(viewModel: viewModel)
            }
        }
    }
    
    // MARK: Основное полотно с элементами
    private func basicElements() -> some View {
        VStack(alignment: .center, spacing: 16) {
            TopBarView(viewModel: viewModel)
                .padding(.top ,16)
                .padding(.horizontal, 16)
            
            InfoWidgetView(viewModel: viewModel)
                .padding(.horizontal, 16)
            
            FullWeekView(viewModel: viewModel)
                .padding(.horizontal, 16)
            
            scrollViewAndLogic()
        }
    }
    
    private func bottomButtons() -> some View {
        VStack {
            Spacer()
            HStack(alignment: .bottom, spacing: 8) {
                Button {
                    isPresentedNewCategoryView.toggle()
                } label: {
                    Text(Localizable.categories)
                        .font(SetupFont.footnoteButton())
                        .frame(maxWidth: .infinity, maxHeight: 32)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule(style: .continuous))
                        .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 0)
                }
                .sheet(isPresented: $isPresentedNewCategoryView) {
                    NewCategoryView(viewModel: viewModel)
                }
                
                Button {
                    isSetShow.toggle()
                } label: {
                    Text(Localizable.settings)
                        .font(SetupFont.footnoteButton())
                        .frame(maxWidth: .infinity, maxHeight: 32)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule(style: .continuous))
                        .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 0)
                }
                
                Button {
                    isPresentedNewExpense.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 28, weight: .regular, design: .rounded))
                        .frame(width: 64, height: 64)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 0)
                }
                .sheet(isPresented: $isPresentedNewExpense) {
                    NewOperationView(viewModel: viewModel)
                }
                
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .transition(.move(edge: .bottom))
    }
    
    // MARK: Все элементы
    private func allView() -> some View {
        ZStack(alignment: .bottom) {
            Color.white.ignoresSafeArea()
            
            // MARK: Основное полотно с элементами
            basicElements()
            
            // MARK: Логика как именно и когда отображать детально меню снизу
            if !viewModel.showDetailedInformation {
                bottomButtons()
            }
            
            // MARK: Отображение и скрытие детального меню
            if viewModel.showDetailedInformation {
                MainDescriptionOperationView(viewModel: viewModel)
                    .padding(16)
                    .transition(.move(edge: .bottom))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.showDetailedInformation)
    }
    
    // MARK: Настройка хедера
    private func HerderView(text: LocalizedStringKey, for array: [FinancesModel]) -> some View {
        HStack {
            Text(text)
                .font(SetupFont.callout())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .opacity(array.isEmpty ? 0 : 1)
            
            Spacer()
            
            Text(viewModel.getAmount(for: array).formattedWithSeparator + "₽")
                .font(SetupFont.callout())
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 16)
                .opacity(array.isEmpty ? 0 : 1)
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//
//  MainView.swift
//  YourFinances
//
//  Created by Максим Боталов on 14.12.2022.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - СВОЙСТВА
    @EnvironmentObject private var viewModel: FinancesViewModel
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
            MainOperationCell(item: item)
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
                NoOperationsView()
            }
        }
    }
    
    // MARK: Основное полотно с элементами
    private func basicElements() -> some View {
        VStack(alignment: .center, spacing: 16) {
            TopBarView()
                .padding(.vertical ,16)
                .padding(.horizontal, 16)
            
            InfoWidgetView()
                .padding(.horizontal, 16)
            
            FullWeekView()
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
                        .background(SetupColor.secondary())
                        .foregroundColor(SetupColor.white())
                        .clipShape(Capsule(style: .continuous))
                        .shadow(color: SetupColor.secondary().opacity(0.3), radius: 10, x: 0, y: 5)
                }
                .sheet(isPresented: $isPresentedNewCategoryView) {
                    NewCategoryView()
                }
                
                Button {
                    isSetShow.toggle()
                } label: {
                    Text(Localizable.settings)
                        .font(SetupFont.footnoteButton())
                        .frame(maxWidth: .infinity, maxHeight: 32)
                        .background(SetupColor.secondary())
                        .foregroundColor(SetupColor.white())
                        .clipShape(Capsule(style: .continuous))
                        .shadow(color: SetupColor.secondary().opacity(0.3), radius: 10, x: 0, y: 5)
                }
                
                Button {
                    isPresentedNewExpense.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 28, weight: .regular, design: .rounded))
                        .frame(width: 64, height: 64)
                        .background(SetupColor.white())
                        .foregroundColor(SetupColor.secondary())
                        .clipShape(Circle())
                        .shadow(color: SetupColor.white().opacity(0.3), radius: 10, x: 0, y: 5)
                }
                .sheet(isPresented: $isPresentedNewExpense) {
                    NewOperationView()
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
            SetupColor.primary().ignoresSafeArea(.all)
            
            // MARK: Основное полотно с элементами
            basicElements()
            
            // MARK: Логика как именно и когда отображать детально меню снизу
            if !viewModel.showDetailedInformation {
                bottomButtons()
            }
            
            // MARK: Отображение и скрытие детального меню
            if viewModel.showDetailedInformation {
                MainDescriptionOperationView()
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
        .foregroundColor(SetupColor.white())
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewLayout(.sizeThatFits)
            .environmentObject(FinancesViewModel())
    }
}

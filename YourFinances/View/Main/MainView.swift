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
    @State private var animationButton = false
    
    // MARK: - ТЕЛО
    var body: some View {
        allView()
    }
    
    // MARK: - ФУНКЦИИ && UI
    
    // Операции
    private func operations(for array: [FinancesModel]) -> some View {
        ForEach(array) { item in
            MainOperationCell(item: item)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 16)
        }
    }
    
    // ScrollView и логика
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
    
    // Основное полотно с элементами
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
    
    // Нижние кнопки
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
                        .foregroundColor(.white)
                        .overlay(content: {
                            Capsule(style: .continuous)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.white)
                        })
                        .clipShape(Capsule(style: .continuous))
                        .shadow(color: viewModel.isExpenseNewCategory ? .white.opacity(0.3) : .clear, radius: 10, x: 0, y: 5)
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
                        .foregroundColor(.white)
                        .overlay(content: {
                            Capsule(style: .continuous)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.white)
                        })
                        .clipShape(Capsule(style: .continuous))
                        .shadow(color: viewModel.isExpenseNewCategory ? .white.opacity(0.3) : .clear, radius: 10, x: 0, y: 5)
                }
                .fullScreenCover(isPresented: $isSetShow) {
                    SettingsView()
                }
                
                Button {
                    isPresentedNewExpense.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 28, weight: .regular, design: .rounded))
                        .frame(width: 72, height: 72)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                .sheet(isPresented: $isPresentedNewExpense) {
                    NewOperationView()
                }
                
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .animation(.spring(), value: viewModel.showDetailedInformation)
        .opacity(viewModel.showDetailedInformation ? 0 : 1)
    }
    
    // Все элементы
    private func allView() -> some View {
        ZStack(alignment: .bottom) {
            SetupColor.primary.ignoresSafeArea(.all)
            
            // MARK: Основное полотно с элементами
            basicElements()
            
            // MARK: Логика как именно и когда отображать детально меню снизу
            VStack {
                Spacer()
                bottomButtons()
            }
            
            // MARK: Отображение и скрытие детального меню
            VStack {
                Spacer()
                MainDescriptionOperationView()
                    .cornerRadius(20)
                    .padding(16)
                    .transition(.move(edge: .bottom))
            }
            .animation(.spring(), value: viewModel.showDetailedInformation)
            .offset(y: viewModel.showDetailedInformation ? 0 : 220)
            .shadow(color: SetupColor.primary.opacity(0.3), radius: 10, x: 0, y: 5)
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.showDetailedInformation)
    }
    
    // Настройка хедера
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
        .foregroundColor(.white)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
            .environmentObject(FinancesViewModel())
    }
}

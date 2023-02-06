//
//  ContentView.swift
//  YourFinances
//
//  Created by Максим Боталов on 13.12.2022.
//

import SwiftUI

struct NewOperationView: View {
    
    // MARK: - СВОЙСТВА
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: FinancesViewModel
    
    // MARK: - ТЕЛО
    var body: some View {
        allView()
    }
    
    // MARK: - ФУНКЦИИ && UI
    // Ввод суммы операции
    private func entryAmount() -> some View {
        HStack(alignment: .center, spacing: 16) {
            Text(Localizable.amount)
                .modifier(CustomText(font: SetupFont.title3(), color: .black))
            
            Text(viewModel.operationAmount + "₽")
                .modifier(AmountField())
        }
    }
    
    // Кнопка сохранения операции
    private func saveOperation() -> some View {
        Button {
            viewModel.saveOperation()
            viewModel.operationAmount = ""
            viewModel.showNumpadView = false
            viewModel.isExpense = true
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text(Localizable.save)
                .modifier(CustomButton(font: SetupFont.callout(), background: viewModel.checkingBeforeSaving() ? .blue : .clear, foreground: viewModel.checkingBeforeSaving() ? .white : .black.opacity(0.1), height: 48, maxWidth: .infinity))
        }
        .disabled(!viewModel.checkingBeforeSaving())
    }
    
    // Все элементы
    private func allView() -> some View {
        ZStack(alignment: .bottom) {
            Color.white.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                // Заголовок
                Text(Localizable.newOperation)
                    .modifier(CustomText(font: SetupFont.title3(), color: .black))
                    .padding(16)
                    .padding(.top, 16)
                
                SelectionButtonsView(isExpense: $viewModel.isExpense)
                    .padding(.horizontal, 16)
                
                entryAmount()
                    .padding(16)
                
                // Отображение категори. Если категорий нет, то отображается предупреждение
                if  viewModel.сheckingForCategories() {
                    ShowCategoriesView()
                        .padding(.horizontal, 16)
                } else {
                    Text(Localizable.noCategory)
                        .modifier(CustomText(font: SetupFont.title3(), color: .black, alignment: .center))
                        .frame(maxWidth: .infinity)
                        .frame(height: 150, alignment: .center)
                }
                
                saveOperation()
                    .padding(16)
                
                // Описание неточностей. После реализации функционала удалить!
                VStack(alignment: .leading, spacing: 8) {
                    Text(Localizable.info1)
                        .modifier(DescriptionText())
                    
                    Text(Localizable.info2)
                        .modifier(DescriptionText())
                    
                }
                .foregroundColor(.white)
                .padding(16)
                
            }
            
            VStack {
                Spacer()
                NumPadView()
                    .cornerRadius(20)
                    .padding(16)
                    
            }
            .animation(.spring(), value: viewModel.showNumpadView)
            .offset(y: viewModel.showNumpadView ? 0 : 370)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct NewOperationView_Previews: PreviewProvider {
    static var previews: some View {
        NewOperationView()
            .environmentObject(FinancesViewModel())
    }
}

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
    
    // MARK: Выбор типа операции
    private func selectionButtons() -> some View {
        HStack(alignment: .center, spacing: 8) {
            Button {
                withAnimation(.spring()) {
                    viewModel.isExpense = true
                }
            } label: {
                Text(Localizable.expense)
                    .font(SetupFont.callout())
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                    .foregroundColor(viewModel.isExpense ? SetupColor.secondary : SetupColor.white)
                    .background(viewModel.isExpense ? SetupColor.white : .clear)
                    .overlay(content: {
                        Capsule(style: .continuous)
                            .stroke(lineWidth: 2)
                            .foregroundColor(SetupColor.white)
                    })
                    .clipShape(Capsule(style: .continuous))
                    .shadow(color: viewModel.isExpense ? SetupColor.white.opacity(0.3) : .clear, radius: 10, x: 0, y: 5)
            }
            Button {
                withAnimation(.spring()) {
                    viewModel.isExpense = false
                }
            } label: {
                Text(Localizable.profit)
                    .font(SetupFont.callout())
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                
                    .foregroundColor(viewModel.isExpense ? SetupColor.white : SetupColor.secondary)
                    .background(viewModel.isExpense ? SetupColor.primary : SetupColor.white)
                    .overlay(content: {
                        Capsule(style: .continuous)
                            .stroke(lineWidth: 2)
                            .foregroundColor(SetupColor.white)
                    })
                    .clipShape(Capsule(style: .continuous))
                    .shadow(color: viewModel.isExpense ?  .clear : SetupColor.white.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            
        }
    }
    
    // MARK: Ввод суммы операции
    private func entryAmount() -> some View {
        HStack(alignment: .center, spacing: 16) {
            Text(Localizable.amount)
                .font(SetupFont.title3())
                .foregroundColor(SetupColor.white)
            
            Text(viewModel.operationAmount + "₽")
                .foregroundColor(viewModel.operationAmount.isEmpty ? SetupColor.primary : SetupColor.white)
                .font(SetupFont.title3())
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(SetupColor.secondary)
                .clipShape(Capsule(style: .continuous))
                .onTapGesture {
                    DispatchQueue.main.async {
                        withAnimation(.spring()) {
                            viewModel.showNumpadView.toggle()
                        }
                    }
                }
        }
    }
    
    // MARK: Кнопка сохранения операции
    private func saveOperation() -> some View {
        Button {
            viewModel.saveOperation()
            viewModel.operationAmount = ""
            viewModel.showNumpadView = false
            viewModel.selectedCategory = CategoryModel(title: "", image: "", locKey: "")
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text(Localizable.save)
                .font(SetupFont.callout())
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(validFields() ? .blue : .clear)
                .foregroundColor(SetupColor.secondary)
                .clipShape(Capsule())
                .shadow(color: validFields() ? .blue.opacity(0.3) : .clear, radius: 10, x: 0, y: 5)
        }
        .disabled(!validFields())
    }
    
    // MARK: Все элементы
    private func allView() -> some View {
        ZStack(alignment: .bottom) {
            
            SetupColor.primary.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                // MARK: Заголовок
                Text(Localizable.newOperation)
                    .font(SetupFont.title3())
                    .foregroundColor(SetupColor.white)
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .padding(.top, 16)
                
                selectionButtons()
                    .padding(.horizontal, 16)
                
                entryAmount()
                    .padding(16)
                
                ShowCategoriesView()
                    .padding(.horizontal, 16)
                
                saveOperation()
                    .padding(16)
                
                // MARK: Описание неточностей. После реализации функционала удалить!
                VStack(alignment: .leading, spacing: 8) {
                    Text(Localizable.info1)
                        .font(SetupFont.footnote())
                    
                    Text(Localizable.info2)
                        .font(SetupFont.footnote())
                    
                }
                .foregroundColor(SetupColor.white)
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
            .shadow(color: SetupColor.primary.opacity(0.3), radius: 10, x: 0, y: 5)

        }
    }
    
    // MARK: Проверка на валидность полей
    private func validFields() -> Bool {
        if viewModel.selectedCategory.image == "" {
            return false
        }
        
        if viewModel.operationAmount == "" {
            return false
        }
        
        return true
    }
    
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct NewOperationView_Previews: PreviewProvider {
    static var previews: some View {
        NewOperationView()
            .environmentObject(FinancesViewModel())
    }
}

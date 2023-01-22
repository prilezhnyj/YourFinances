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
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.isExpense = true
                }
            } label: {
                Text(Localizable.expense)
                    .font(SetupFont.callout())
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                    .foregroundColor(viewModel.isExpense ? .white : .black)
                    .background(viewModel.isExpense ? Color.black : Color.white)
                    .clipShape(Capsule(style: .continuous))
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
            }
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.isExpense = false
                }
            } label: {
                Text(Localizable.profit)
                    .font(SetupFont.callout())
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                    .foregroundColor(viewModel.isExpense ? .black : .white)
                    .background(viewModel.isExpense ? Color.white : Color.black)
                    .clipShape(Capsule(style: .continuous))
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
            }
            
        }
    }
    
    // MARK: Ввод суммы операции
    private func entryAmount() -> some View {
        HStack(alignment: .center, spacing: 16) {
            Text(Localizable.amount)
                .font(SetupFont.title3())
            
            Text(viewModel.operationAmount + "₽")
                .foregroundColor(viewModel.operationAmount.isEmpty ? .black.opacity(0.5) : .black)
                .font(SetupFont.title3())
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(Color.black.opacity(0.1))
                .clipShape(Capsule(style: .continuous))
                .onTapGesture {
                    viewModel.showNumpadView.toggle()
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
                .frame(height: 40)
                .background(validFields() ? Color.black : Color.black.opacity(0.1))
                .foregroundColor(validFields() ? Color.white : Color.black.opacity(0.1))
                .clipShape(Capsule(style: .continuous))
                .shadow(color: .blue.opacity(0.1), radius: 10, x: 0, y: 0)
        }
        .disabled(!validFields())
    }
    
    // MARK: Все элементы
    private func allView() -> some View {
        ZStack(alignment: .bottom) {
            
            Color.white.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                // MARK: Заголовок
                Text(Localizable.newOperation)
                    .font(SetupFont.title3())
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 16)
                
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
                        .foregroundColor(.black.opacity(0.5))
                    
                    Text(Localizable.info2)
                        .font(SetupFont.footnote())
                        .foregroundColor(.black.opacity(0.5))
                    
                }
                .padding(.horizontal, 16)
                
            }
            
            if viewModel.showNumpadView {
                NumPadView()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                    .transition(.move(edge: .bottom))
                    .padding(16)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.showNumpadView)
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
    }
}

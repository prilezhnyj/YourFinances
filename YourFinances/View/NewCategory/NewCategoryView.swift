//
//  AddNewCategoryView.swift
//  YourFinances
//
//  Created by Максим Боталов on 10.01.2023.
//

import SwiftUI

struct NewCategoryView: View {
    
    // MARK: - СВОЙСТВА
    @ObservedObject var viewModel: FinancesViewModel
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - ТЕЛО
    var body: some View {
        allViewInScrollView()
    }
    
    // MARK: - ФУНКЦИИ && UI
    
    // MARK: Кнопки выбора категории
    private func selectionButtons() -> some View {
        HStack(alignment: .center, spacing: 8) {
            Button {
                viewModel.isExpenseNewCategory = true
            } label: {
                Text(Localizable.expense)
                    .font(SetupFont.callout())
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                    .foregroundColor(viewModel.isExpenseNewCategory ? .white : .black)
                    .background(viewModel.isExpenseNewCategory ? Color.black : Color.white)
                    .clipShape(Capsule(style: .continuous))
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
            }
            
            Button {
                viewModel.isExpenseNewCategory = false
            } label: {
                Text(Localizable.profit)
                    .font(SetupFont.callout())
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                    .foregroundColor(viewModel.isExpenseNewCategory ? .black : .white)
                    .background(viewModel.isExpenseNewCategory ? Color.white : Color.black)
                    .clipShape(Capsule(style: .continuous))
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
            }
            
        }
    }
    
    // MARK: Название категории и иконка
    private func titleCategory() -> some View {
        HStack {
            TextField(Localizable.categoryTitle, text: $viewModel.newTitleCategory)
                .foregroundColor(viewModel.newTitleCategory == "" ? .black.opacity(0.5) : .black)
                .font(SetupFont.title3())
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(Color.black.opacity(0.1))
                .clipShape(Capsule(style: .continuous))
            
            TextField("A", text: $viewModel.newImageCategory)
                .foregroundColor(viewModel.newImageCategory == "" ? .black.opacity(0.1) : .black)
                .font(SetupFont.title3())
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .frame(width: 60, height: 40, alignment: .center)
                .background(Color.black.opacity(0.1))
                .clipShape(Capsule(style: .continuous))
                .onChange(of: viewModel.newImageCategory) { newValue in
                    viewModel.newImageCategory = String(viewModel.newImageCategory.prefix(1))
                }
        }
    }
    
    // MARK: Кнопка сохранения операции
    private func saveOperation() -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.25)) {
                viewModel.addNewCategory()
            }
            viewModel.newTitleCategory = ""
            viewModel.newImageCategory = ""
            viewModel.isExpenseNewCategory = true
        } label: {
            Text(Localizable.save)
                .font(SetupFont.callout())
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(viewModel.newTitleCategory == "" || viewModel.newImageCategory == ""  ? Color.black.opacity(0.1) : Color.black)
                .foregroundColor(viewModel.newTitleCategory == "" || viewModel.newImageCategory == ""  ? Color.black.opacity(0.5) : Color.white)
                .clipShape(Capsule())
                .shadow(color: .blue.opacity(0.1), radius: 10, x: 0, y: 0)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        }
        .disabled(viewModel.newTitleCategory == "" || viewModel.newImageCategory == "" ? true : false)
    }
    
    private func categories(for array: [CategoryModel]) -> some View {
        ForEach(array) { item in
            CategoryRowView(item: item,viewModel: viewModel)
        }
    }
    
    // MARK: Общая сетка
    private func gridCategories() -> some View {
        LazyVGrid(columns: [GridItem(.flexible())], alignment: .leading, spacing: 8) {
            if !viewModel.expenseCategoriesArray.isEmpty {
                Section {
                    categories(for: viewModel.expenseCategoriesArray)
                } header: {
                    HeaderView(for: viewModel.expenseCategoriesArray.isEmpty ? "" : Localizable.expenses)
                }
            }
            
            if !viewModel.profitsCategoriesArray.isEmpty {
                Section {
                    categories(for: viewModel.profitsCategoriesArray)
                } header: {
                    HeaderView(for: viewModel.profitsCategoriesArray.isEmpty ? "" : Localizable.profits)
                }

            }
        }
    }
    
    // MARK: Все элементы
    private func allViewInScrollView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            // MARK: Заголовок
            Text(Localizable.newCategory)
                .font(SetupFont.title3())
                .frame(maxWidth: .infinity)
                .padding(16)
            
            selectionButtons()
                .padding(.horizontal, 16)
            
            titleCategory()
                .padding(16)
            
            saveOperation()
            
            Divider()
                .padding(16)
            
            // MARK: Заголовок
            Text(Localizable.yourCategories)
                .font(SetupFont.title3())
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
            
            gridCategories()
                .padding(16)
        }
    }
    
    // MARK: Настройка хедера
    func HeaderView(for text: LocalizedStringKey) -> some View {
        Text(text)
            .font(SetupFont.callout())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
    }
}

struct NewCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewCategoryView(viewModel: FinancesViewModel())
    }
}

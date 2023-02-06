//
//  AddNewCategoryView.swift
//  YourFinances
//
//  Created by Максим Боталов on 10.01.2023.
//

import SwiftUI

struct NewCategoryView: View {
    
    // MARK: - СВОЙСТВА
    @EnvironmentObject var viewModel: FinancesViewModel
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - ТЕЛО
    var body: some View {
        allViewInScrollView()
    }
    
    // MARK: - ФУНКЦИИ && UI
    // Название категории и иконка
    private func titleCategory() -> some View {
        HStack {
            TextField(Localizable.categoryTitle, text: $viewModel.newTitleCategory)
                .foregroundColor(.black)
                .font(SetupFont.title3())
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(.white)
                .clipShape(Capsule(style: .continuous))
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            
            TextField("🦊", text: $viewModel.newImageCategory)
                .foregroundColor(.black)
                .font(SetupFont.title3())
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .frame(width: 72, height: 48, alignment: .center)
                .background(.white)
                .clipShape(Capsule(style: .continuous))
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                .onChange(of: viewModel.newImageCategory) { newValue in
                    viewModel.newImageCategory = String(viewModel.newImageCategory.prefix(1))
                }
        }
    }
    
    // Кнопка сохранения операции
    private func saveOperation() -> some View {
        Button {
            withAnimation(.spring()) {
                viewModel.addNewCategory()
            }
            viewModel.newTitleCategory = ""
            viewModel.newImageCategory = ""
            viewModel.isExpenseNewCategory = true
        } label: {
            Text(Localizable.save)
                .font(SetupFont.callout())
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(viewModel.newTitleCategory == "" || viewModel.newImageCategory == ""  ? .clear : .blue)
                .foregroundColor(viewModel.newTitleCategory == "" || viewModel.newImageCategory == ""  ? .black.opacity(0.1) : .white)
                .clipShape(Capsule())
                .shadow(color: viewModel.newTitleCategory == "" || viewModel.newImageCategory == "" ? .clear : .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        }
        .disabled(viewModel.newTitleCategory == "" || viewModel.newImageCategory == "" ? true : false)
    }
    
    // Список категории
    private func categories(for array: [CategoryModel]) -> some View {
        ForEach(array) { item in
            CategoryRowView(item: item)
        }
    }
    
    // Общая сетка
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
    
    // Все элементы
    private func allViewInScrollView() -> some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                // Заголовок
                Text(Localizable.newCategory)
                    .font(SetupFont.title3())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .padding(.top, 16)
                
                SelectionButtonsView(isExpense: $viewModel.isExpenseNewCategory)
                    .padding(.horizontal, 16)
                
                titleCategory()
                    .padding(16)
                
                saveOperation()
                
                if viewModel.newTitleCategory == "" || viewModel.newImageCategory == "" {
                    Text(Localizable.descriptionSavingCategory)
                        .foregroundColor(.black)
                        .font(SetupFont.footnote())
                        .padding(16)
                }
                
                if !viewModel.expenseCategoriesArray.isEmpty || !viewModel.profitsCategoriesArray.isEmpty {
                    Divider()
                        .background(.black.opacity(0.1))
                        .padding(16)
                    
                    // MARK: Заголовок
                    Text(Localizable.yourCategories)
                        .font(SetupFont.title3())
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                    
                    gridCategories()
                        .padding(16)
                }
            }
        }
    }
    
    // Настройка хедера
    func HeaderView(for text: LocalizedStringKey) -> some View {
        Text(text)
            .font(SetupFont.callout())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .foregroundColor(.black)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct NewCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewCategoryView()
            .environmentObject(FinancesViewModel())
    }
}

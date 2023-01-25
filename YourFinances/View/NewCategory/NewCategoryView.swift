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
    
    // MARK: Кнопки выбора категории
    private func selectionButtons() -> some View {
        HStack(alignment: .center, spacing: 8) {
            Button {
                withAnimation(.spring()) {
                    viewModel.isExpenseNewCategory = true
                }
            } label: {
                Text(Localizable.expense)
                    .font(SetupFont.callout())
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                    .foregroundColor(viewModel.isExpenseNewCategory ? SetupColor.secondary : SetupColor.white)
                    .background(viewModel.isExpenseNewCategory ? SetupColor.white : .clear)
                    .overlay(content: {
                        Capsule(style: .continuous)
                            .stroke(lineWidth: 2)
                            .foregroundColor(SetupColor.white)
                    })
                    .clipShape(Capsule(style: .continuous))
                    .shadow(color: viewModel.isExpenseNewCategory ? SetupColor.white.opacity(0.3) : .clear, radius: 10, x: 0, y: 5)
            }
            Button {
                withAnimation(.spring()) {
                    viewModel.isExpenseNewCategory = false
                }
            } label: {
                Text(Localizable.profit)
                    .font(SetupFont.callout())
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                
                    .foregroundColor(viewModel.isExpenseNewCategory ? SetupColor.white : SetupColor.secondary)
                    .background(viewModel.isExpenseNewCategory ? SetupColor.primary : SetupColor.white)
                    .overlay(content: {
                        Capsule(style: .continuous)
                            .stroke(lineWidth: 2)
                            .foregroundColor(SetupColor.white)
                    })
                    .clipShape(Capsule(style: .continuous))
                    .shadow(color: viewModel.isExpenseNewCategory ?  .clear : SetupColor.white.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            
        }
    }
    
    // MARK: Название категории и иконка
    private func titleCategory() -> some View {
        HStack {
            TextField(Localizable.categoryTitle, text: $viewModel.newTitleCategory)
                .foregroundColor(viewModel.newTitleCategory == "" ? SetupColor.primary : SetupColor.white)
                .font(SetupFont.title3())
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(SetupColor.secondary)
                .clipShape(Capsule(style: .continuous))
            
            TextField("🦊", text: $viewModel.newImageCategory)
                .foregroundColor(viewModel.newImageCategory == "" ? SetupColor.primary : SetupColor.white)
                .font(SetupFont.title3())
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .frame(width: 72, height: 48, alignment: .center)
                .background(SetupColor.secondary)
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
                .frame(height: 48)
                .background(viewModel.newTitleCategory == "" || viewModel.newImageCategory == ""  ? SetupColor.primary : .blue)
                .foregroundColor(SetupColor.secondary)
                .clipShape(Capsule())
                .shadow(color: viewModel.newTitleCategory == "" || viewModel.newImageCategory == "" ? .clear : .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        }
        .disabled(viewModel.newTitleCategory == "" || viewModel.newImageCategory == "" ? true : false)
    }
    
    private func categories(for array: [CategoryModel]) -> some View {
        ForEach(array) { item in
            CategoryRowView(item: item)
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
        ZStack {
            SetupColor.primary.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                // MARK: Заголовок
                Text(Localizable.newCategory)
                    .font(SetupFont.title3())
                    .foregroundColor(SetupColor.white)
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .padding(.top, 16)
                
                selectionButtons()
                    .padding(.horizontal, 16)
                
                titleCategory()
                    .padding(16)
                
                saveOperation()
                
                if viewModel.newTitleCategory == "" || viewModel.newImageCategory == "" {
                    Text(Localizable.descriptionSavingCategory)
                        .foregroundColor(SetupColor.white)
                        .font(SetupFont.footnote())
                        .padding(16)
                }
                
                Divider()
                    .background(SetupColor.white)
                    .padding(16)
                
                // MARK: Заголовок
                Text(Localizable.yourCategories)
                    .font(SetupFont.title3())
                    .foregroundColor(SetupColor.white)
                    .frame(maxWidth: .infinity)
                
                gridCategories()
                    .padding(16)
            }
        }
    }
    
    // MARK: Настройка хедера
    func HeaderView(for text: LocalizedStringKey) -> some View {
        Text(text)
            .font(SetupFont.callout())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .foregroundColor(SetupColor.white)
    }
}

struct NewCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewCategoryView()
            .environmentObject(FinancesViewModel())
    }
}

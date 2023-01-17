//
//  AddNewCategoryView.swift
//  YourFinances
//
//  Created by Максим Боталов on 10.01.2023.
//

import SwiftUI

struct NewCategoryView: View {
    @ObservedObject var viewModel: FinancesViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text("New category")
                .font(SetupFont.title3())
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 32)
            
            HStack(alignment: .center, spacing: 8) {
                Button {
                    viewModel.isExpenseNewCategory = true
                } label: {
                    Text("Expense")
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
                    Text("Profit")
                        .font(SetupFont.callout())
                        .frame(maxWidth: .infinity)
                        .frame(height: 32)
                        .foregroundColor(viewModel.isExpenseNewCategory ? .black : .white)
                        .background(viewModel.isExpenseNewCategory ? Color.white : Color.black)
                        .clipShape(Capsule(style: .continuous))
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                }
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            HStack {
                TextField("Category title", text: $viewModel.newTitleCategory)
                    .foregroundColor(viewModel.newTitleCategory == "" ? .black.opacity(0.5) : .black)
                    .font(SetupFont.title3())
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.black.opacity(0.1))
                    .clipShape(Capsule(style: .continuous))
                
                TextField("A", text: $viewModel.newImageCategory)
                    .foregroundColor(viewModel.newImageCategory == "" ? .black.opacity(0.1) : .black)
                    .font(SetupFont.title3())
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .frame(width: 60, height: 48, alignment: .center)
                    .background(Color.black.opacity(0.1))
                    .clipShape(Capsule(style: .continuous))
                    .onChange(of: viewModel.newImageCategory) { newValue in
                        viewModel.newImageCategory = String(viewModel.newImageCategory.prefix(1))
                    }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                    viewModel.addNewCategory()
                }
                viewModel.newTitleCategory = ""
                viewModel.newImageCategory = ""
                viewModel.isExpenseNewCategory = true
            } label: {
                Text("Save")
                    .font(SetupFont.callout())
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(viewModel.newTitleCategory == "" || viewModel.newImageCategory == ""  ? Color.black.opacity(0.1) : Color.black)
                    .foregroundColor(viewModel.newTitleCategory == "" || viewModel.newImageCategory == ""  ? Color.black.opacity(0.5) : Color.white)
                    .clipShape(Capsule())
                    .shadow(color: .blue.opacity(0.1), radius: 10, x: 0, y: 0)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
            }
            .disabled(viewModel.newTitleCategory == "" || viewModel.newImageCategory == "" ? true : false)
            
            Divider()
                .padding(16)
            
            Text("Your categories")
                .font(SetupFont.title3())
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            
            LazyVGrid(columns: [GridItem(.flexible(minimum: 300, maximum: 414))], alignment: .leading, spacing: 8) {
                Section {
                    ForEach(viewModel.expenseCategoriesArray) { item in
                        CategoryRowView(item: item,viewModel: viewModel)
                    }
                } header: {
                    HeaderView(for: viewModel.expenseCategoriesArray.isEmpty ? "" : "Expenses")
                }
                
                Section {
                    ForEach(viewModel.profitsCategoriesArray) { item in
                        CategoryRowView(item: item,viewModel: viewModel)
                    }
                } header: {
                    HeaderView(for: viewModel.profitsCategoriesArray.isEmpty ? "" : "Profits")
                }
            }
            .padding(16)
        }
    }
    
    func HeaderView(for text: String) -> some View {
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

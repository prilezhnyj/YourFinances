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
            Text("Новая категория")
                .font(SetupFont.title3())
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 32)
            
            HStack(alignment: .center, spacing: 8) {
                Button {
                    viewModel.isMinusNewCategory = true
                } label: {
                    Text("Расход")
                        .font(SetupFont.callout())
                        .frame(maxWidth: .infinity)
                        .frame(height: 32)
                        .foregroundColor(viewModel.isMinus ? .white : .black)
                        .background(viewModel.isMinus ? Color.black : Color.white)
                        .clipShape(Capsule(style: .continuous))
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                }
                
                Button {
                    viewModel.isMinusNewCategory = false
                } label: {
                    Text("Доход")
                        .font(SetupFont.callout())
                        .frame(maxWidth: .infinity)
                        .frame(height: 32)
                        .foregroundColor(viewModel.isMinus ? .black : .white)
                        .background(viewModel.isMinus ? Color.white : Color.black)
                        .clipShape(Capsule(style: .continuous))
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                }
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            HStack {
                TextField("Название категории", text: $viewModel.titleCategory)
                    .foregroundColor(viewModel.titleCategory == "" ? .black.opacity(0.5) : .black)
                    .font(SetupFont.title3())
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.black.opacity(0.1))
                    .clipShape(Capsule(style: .continuous))
                
                TextField("А", text: $viewModel.imageCategory)
                    .foregroundColor(viewModel.imageCategory == "" ? .black.opacity(0.1) : .black)
                    .font(SetupFont.title3())
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .frame(width: 60, height: 48, alignment: .center)
                    .background(Color.black.opacity(0.1))
                    .clipShape(Capsule(style: .continuous))
                    .onChange(of: viewModel.imageCategory) { newValue in
                        viewModel.imageCategory = String(viewModel.imageCategory.prefix(1))
                    }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                    viewModel.addNewCategory()
                }
                viewModel.titleCategory = ""
                viewModel.imageCategory = ""
                viewModel.isMinusNewCategory = true
            } label: {
                Text("Сохранить")
                    .font(SetupFont.callout())
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(viewModel.titleCategory == "" || viewModel.imageCategory == ""  ? Color.black.opacity(0.1) : Color.black)
                    .foregroundColor(viewModel.titleCategory == "" || viewModel.imageCategory == ""  ? Color.black.opacity(0.5) : Color.white)
                    .clipShape(Capsule())
                    .shadow(color: .blue.opacity(0.1), radius: 10, x: 0, y: 0)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
            }
            .disabled(viewModel.titleCategory == "" || viewModel.imageCategory == "" ? true : false)
            
            Divider()
                .padding(16)
            
            Text("Ваши категории")
                .font(SetupFont.title3())
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            
            LazyVGrid(columns: [GridItem(.flexible(minimum: 300, maximum: 414))], alignment: .leading, spacing: 8) {
                Section {
                    ForEach(viewModel.categoryMinusArray) { item in
                        CategoryRowView(item: item,viewModel: viewModel)
                    }
                } header: {
                    HeaderView(for: viewModel.categoryMinusArray.isEmpty ? "" : "Расходы")
                }
                
                Section {
                    ForEach(viewModel.categoryPlusArray) { item in
                        CategoryRowView(item: item,viewModel: viewModel)
                    }
                } header: {
                    HeaderView(for: viewModel.categoryPlusArray.isEmpty ? "" : "Доходы")
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

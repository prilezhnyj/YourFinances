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
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity)
                .padding(16)
                .padding(.top, 16)
            
            HStack(alignment: .center, spacing: 8) {
                Button {
                    viewModel.isMinusNewCategory = true
                } label: {
                    Text("Расход")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .frame(maxWidth: .infinity)
                        .frame(height: 34)
                        .foregroundColor(viewModel.isMinusNewCategory ? .white : .black)
                        .background(viewModel.isMinusNewCategory ? Color.black : Color.white)
                        .cornerRadius(48)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                }
                Button {
                    viewModel.isMinusNewCategory = false
                } label: {
                    Text("Доход")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .frame(maxWidth: .infinity)
                        .frame(height: 34)
                        .foregroundColor(viewModel.isMinusNewCategory ? .black : .white)
                        .background(viewModel.isMinusNewCategory ? Color.white : Color.black)
                        .cornerRadius(48)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                }
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            HStack {
                TextField("Название категории", text: $viewModel.titleCategory)
                    .foregroundColor(viewModel.titleCategory == "" ? . gray : .black)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding(.horizontal, 16)
                    .textFieldStyle(.plain)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(Capsule(style: .continuous))
                
                TextField("А", text: $viewModel.imageCategory)
                    .foregroundColor(viewModel.imageCategory == "" ? . gray : .black)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .textFieldStyle(.plain)
                    .frame(width: 60, height: 48, alignment: .center)
                    .background(Color.gray.opacity(0.1))
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
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(viewModel.titleCategory == "" || viewModel.imageCategory == ""  ? Color.gray.opacity(0.1) : Color.blue)
                    .foregroundColor(viewModel.titleCategory == "" || viewModel.imageCategory == ""  ? Color.gray : Color.white)
                    .clipShape(Capsule())
                    .shadow(color: .blue.opacity(0.1), radius: 10, x: 0, y: 0)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5), value: viewModel.showFullCategories)
            }
            .disabled(viewModel.titleCategory == "" || viewModel.imageCategory == "" ? true : false)
            
            Divider()
                .padding(16)
            
            Text("Ваши категории")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            
            LazyVGrid(columns: [GridItem(.flexible(minimum: 320, maximum: 414))], alignment: .leading, spacing: 8) {
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
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
    
    func HeaderView(for text: String) -> some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 16, weight: .bold, design: .rounded))
            .padding(.horizontal, 16)
    }
}



struct NewCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewCategoryView(viewModel: FinancesViewModel())
    }
}

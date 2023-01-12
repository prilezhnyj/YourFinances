//
//  CategoryView.swift
//  YourFinances
//
//  Created by Максим Боталов on 16.12.2022.
//

import SwiftUI

struct ShowCategoriesView: View {
    @ObservedObject var viewModel: FinancesViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Text("Категории")
                    .font(SetupFont.callout())
                
                Spacer()
                
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.showFullCategories.toggle()
                    }
                } label: {
                    Text(viewModel.showFullCategories ? "Скрыть" : "Показать")
                        .font(SetupFont.callout())
                        .foregroundColor(viewModel.showFullCategories ? .red : .black.opacity(0.1))
                }
            }
            .padding(16)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], alignment: .center, spacing: 16) {
                    if viewModel.isMinus {
                        ForEach(viewModel.categoryMinusArray) { item in
                            VStack {
                                Text(item.image)
                                    .frame(minWidth: 48, minHeight: 48)
                                    .background(viewModel.selectedCategory.id == item.id ? Color.green : Color.black.opacity(0.1))
                                    .clipShape(Circle())
                                Text(item.title)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .font(SetupFont.footnote())
                                    .foregroundColor(viewModel.selectedCategory.id == item.id ? Color.green : Color.black)
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    viewModel.selectedCategory = item
                                }
                            }
                        }
                    } else {
                        ForEach(viewModel.categoryPlusArray) { item in
                            VStack {
                                Text(item.image)
                                    .frame(minWidth: 48, minHeight: 48)
                                    .background(viewModel.selectedCategory.id == item.id ? Color.green : Color.black.opacity(0.1))
                                    .clipShape(Circle())
                                Text(item.title)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .font(SetupFont.footnote())
                                    .foregroundColor(viewModel.selectedCategory.id == item.id ? Color.green : Color.black)
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    viewModel.selectedCategory = item
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: viewModel.showFullCategories ? 250 : 160)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
        .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5), value: viewModel.showFullCategories)
    }
}

struct ShowCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        ShowCategoriesView(viewModel: FinancesViewModel())
            .previewLayout(.sizeThatFits)
    }
}

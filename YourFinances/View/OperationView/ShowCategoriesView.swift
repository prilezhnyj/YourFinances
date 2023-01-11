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
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 10) {
                Text("Категории")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                
                Spacer()
                
                Button(viewModel.showFullCategories ? "Скрыть" : "Показать") {
                    viewModel.showFullCategories.toggle()
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))], alignment: .center, spacing: 20) {
                    if viewModel.isMinus {
                        ForEach(viewModel.categoryMinusArray) { item in
                            VStack {
                                Text(item.image)
                                    .frame(minWidth: 50, minHeight: 50)
                                    .background(viewModel.selectedCategory.id == item.id ? Color.green.opacity(0.5) : Color.gray.opacity(0.1))
                                    .clipShape(Circle())
                                Text(item.title)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                                    .foregroundColor(viewModel.selectedCategory.id == item.id ? Color.green : Color.black)
                            }
                            .onTapGesture {
                                withAnimation {
                                    viewModel.selectedCategory = item
                                }
                            }
                        }
                    } else {
                        ForEach(viewModel.categoryPlusArray) { item in
                            VStack {
                                Text(item.image)
                                    .frame(minWidth: 50, minHeight: 50)
                                    .background(viewModel.selectedCategory.id == item.id ? Color.green.opacity(0.5) : Color.gray.opacity(0.1))
                                    .clipShape(Circle())
                                
                                Text(item.title)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                                    .foregroundColor(viewModel.selectedCategory.id == item.id ? Color.green : Color.black)
                            }
                            .onTapGesture {
                                withAnimation {
                                    viewModel.selectedCategory = item
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: viewModel.showFullCategories ? 300 : 180)
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

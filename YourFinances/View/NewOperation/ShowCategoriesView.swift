//
//  CategoryView.swift
//  YourFinances
//
//  Created by Максим Боталов on 16.12.2022.
//

import SwiftUI

struct ShowCategoriesView: View {
    
    // MARK: - СВОЙСТВА
    @EnvironmentObject var viewModel: FinancesViewModel
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8, alignment: .center),
        GridItem(.flexible(), spacing: 8, alignment: .center),
        GridItem(.flexible(), spacing: 8, alignment: .center),
        GridItem(.flexible(), spacing: 8, alignment: .center),
    ]
    
    // MARK: - ТЕЛО
    var body: some View {
        allView()
    }
    
    // MARK: - ФУНКЦИИ && UI
    // Хедер View
    private func headerView() -> some View {
        HStack(alignment: .center, spacing: 0) {
            
            // Заголовок
            Text(Localizable.categories)
                .font(SetupFont.callout())
                .foregroundColor(.black)
            
            Spacer()
            
            // Кнопка раскрытия и закрытия всех категории
            Button {
                withAnimation(.spring()) {
                    viewModel.showAllCategories.toggle()
                }
            } label: {
                Text(viewModel.showAllCategories ? Localizable.hide : Localizable.show)
                    .font(SetupFont.callout())
                    .foregroundColor(viewModel.showAllCategories ? .red : .black.opacity(0.1))
                    .shadow(color: viewModel.showAllCategories ? .red.opacity(0.3) : .clear, radius: 10, x: 0, y: 5)
            }
        }
        .padding(16)
    }
    
    // Категории
    private func categories(for array: [CategoryModel]) -> some View {
        ForEach(array) { item in
            VStack {
                // Фон иконки
                Text(item.image)
                    .frame(minWidth: 48, minHeight: 48)
                    .background(viewModel.selectedCategory.id == item.id ? Color.green : .black.opacity(0.1))
                    .clipShape(Circle())
                
                // Текст категории
                Text(Localizable.getKey(for: item.locKey))
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .font(SetupFont.footnote())
                    
                
            }
            .foregroundColor(viewModel.selectedCategory.id == item.id ? Color.green : .black)
            .shadow(color: viewModel.selectedCategory.id == item.id ? Color.green.opacity(0.3) : .clear, radius: 10, x: 0, y: 5)
            .onTapGesture {
                withAnimation(.spring()) {
                    viewModel.selectedCategory = item
                }
            }
            .onAppear {
                DispatchQueue.main.async {
                    viewModel.selectedCategory = array.first ?? CategoryModel(title: "", image: "", locKey: "")
                }
            }
        }
    }
    
    // Общая сетка
    private func gridCategories() -> some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
            if viewModel.isExpense {
                categories(for: viewModel.expenseCategoriesArray)
            }
            
            if !viewModel.isExpense {
                categories(for: viewModel.profitsCategoriesArray)
            }
        }
        .padding(.horizontal, 16)
    }
    
    // Сетка в ScrollView
    private func gridInScrollView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            gridCategories()
        }
    }
    
    // Все элементы
    private func allView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView()
            gridInScrollView()
        }
        .frame(height: viewModel.showAllCategories ? 230 : 150)
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        .animation(.spring(), value: viewModel.showAllCategories)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct ShowCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        ShowCategoriesView()
            .previewLayout(.sizeThatFits)
            .environmentObject(FinancesViewModel())
    }
}

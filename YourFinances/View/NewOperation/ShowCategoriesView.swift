//
//  CategoryView.swift
//  YourFinances
//
//  Created by Максим Боталов on 16.12.2022.
//

import SwiftUI

struct ShowCategoriesView: View {
    
    // MARK: - СВОЙСТВА
    @ObservedObject var viewModel: FinancesViewModel
    
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
    
    // MARK: Хедер View
    func headerView() -> some View {
        HStack(alignment: .center, spacing: 0) {
            
            // MARK: Заголовок
            Text(Localizable.categories)
                .font(SetupFont.callout())
            
            Spacer()
            
            // MARK: Кнопка раскрытия и закрытия всех категории
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.showAllCategories.toggle()
                }
            } label: {
                Text(viewModel.showAllCategories ? Localizable.hide : Localizable.show)
                    .font(SetupFont.callout())
                    .foregroundColor(viewModel.showAllCategories ? .red : .black.opacity(0.1))
            }
        }
        .padding(16)
    }
    
    // MARK: Категории расходов
    func expenseCategories() -> some View {
        ForEach(viewModel.expenseCategoriesArray) { item in
            VStack {
                Text(item.image)
                    .frame(minWidth: 48, minHeight: 48)
                    .background(viewModel.selectedCategory.id == item.id ? Color.green : Color.black.opacity(0.1))
                    .clipShape(Circle())
                Text(Localizable.getKey(for: item.locKey))
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
    
    // MARK: Категории доходов
    func profitsCategories() -> some View {
        ForEach(viewModel.profitsCategoriesArray) { item in
            VStack {
                Text(item.image)
                    .frame(minWidth: 48, minHeight: 48)
                    .background(viewModel.selectedCategory.id == item.id ? Color.green : Color.black.opacity(0.1))
                    .clipShape(Circle())
                Text(Localizable.getKey(for: item.locKey))
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
    
    // MARK: Общая сетка
    func gridCategories() -> some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
            if viewModel.isExpense {
                expenseCategories()
            }
            
            if !viewModel.isExpense {
                profitsCategories()
            }
        }
        .padding(.horizontal, 16)
    }
    
    // MARK: Сетка в ScrollView
    func gridInScrollView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            gridCategories()
        }
    }
    
    // MARK: Все элементы
    func allView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView()
            
            gridInScrollView()
        }
        .frame(height: viewModel.showAllCategories ? 250 : 160)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
        .animation(.easeInOut(duration: 0.2), value: viewModel.showAllCategories)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct ShowCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        ShowCategoriesView(viewModel: FinancesViewModel())
            .previewLayout(.sizeThatFits)
    }
}

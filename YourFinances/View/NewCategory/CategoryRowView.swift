//
//  CheckCategoryView.swift
//  YourFinances
//
//  Created by Максим Боталов on 10.01.2023.
//

import SwiftUI

struct CategoryRowView: View {
    
    // MARK: - СВОЙСТВА
    @State var item: CategoryModel
    @ObservedObject var viewModel: FinancesViewModel
    
    // MARK: - ТЕЛО
    var body: some View {
        allView()
    }
    
    // MARK: - ФУНКЦИИ && UI
    
    // MARK: Все элементы
    private func allView() -> some View {
        HStack(alignment: .center, spacing: 16) {
            // MARK: Картинка
            Text(item.image)
                .font(SetupFont.footnote())
                .frame(minWidth: 40, minHeight: 40)
                .background(Color.black.opacity(0.1))
                .clipShape(Circle())
            
            // MARK: Название
            Text(Localizable.getKey(for: item.locKey))
                .font(SetupFont.callout())
            
            Spacer()
            
            // MARK: Кнопка удаления
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.deleteCategory(category: item)
                }
            } label: {
                Image(systemName: "trash")
                    .font(SetupFont.callout())
                    .foregroundColor(.red)
            }
            
        }
        .padding(.leading, 16)
        .padding(.trailing, 32)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRowView(item: CategoryModel(title: "Products", image: "🥬", locKey: "products"), viewModel: FinancesViewModel())
            .previewLayout(.sizeThatFits)
    }
}

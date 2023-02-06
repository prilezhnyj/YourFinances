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
    @EnvironmentObject var viewModel: FinancesViewModel
    
    // MARK: - ТЕЛО
    var body: some View {
        allView()
    }
    
    // MARK: - ФУНКЦИИ && UI
    // Все элементы
    private func allView() -> some View {
        HStack(alignment: .center, spacing: 16) {
            // Картинка
            Text(item.image)
                .font(SetupFont.footnote())
                .frame(minWidth: 40, minHeight: 40)
                .background(.black.opacity(0.1))
                .clipShape(Circle())
            
            // Название
            Text(Localizable.getKey(for: item.locKey))
                .font(SetupFont.callout())
                .foregroundColor(.black)
            
            Spacer()
            
            // Кнопка удаления
            Button {
                withAnimation(.spring()) {
                    viewModel.deleteCategory(category: item)
                }
            } label: {
                Image(systemName: "trash")
                    .font(SetupFont.callout())
                    .foregroundColor(.red)
                    .shadow(color: .red.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            
        }
        .padding(.leading, 16)
        .padding(.trailing, 32)
        .padding(.vertical, 8)
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRowView(item: CategoryModel(title: "Products", image: "🥬", locKey: "products"))
            .previewLayout(.sizeThatFits)
            .environmentObject(FinancesViewModel())
    }
}

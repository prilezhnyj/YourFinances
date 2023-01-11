//
//  CheckCategoryView.swift
//  YourFinances
//
//  Created by Максим Боталов on 10.01.2023.
//

import SwiftUI

struct CategoryRowView: View {
    @State var item: CategoryModel
    @ObservedObject var viewModel: FinancesViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Text(item.image)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .frame(minWidth: 50, minHeight: 50)
                .background(Color.gray.opacity(0.1))
                .clipShape(Circle())
            
            Text(item.title)
                .font(.system(size: 16, weight: .semibold, design: .default))
            
            Spacer()
            
            Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                    viewModel.deleteCategory(item: item)
                }
            } label: {
                Image(systemName: "trash")
                    .font(.system(size: 16, weight: .semibold, design: .default))
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

struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRowView(item: CategoryModel(title: "Проверка", image: "🏡"), viewModel: FinancesViewModel())
            .previewLayout(.sizeThatFits)
    }
}

//
//  OperationCell.swift
//  YourFinances
//
//  Created by Максим Боталов on 15.12.2022.
//

import SwiftUI

struct MainOperationCell: View {
    
    // MARK: - СВОЙСТВА
    @EnvironmentObject var viewModel: FinancesViewModel
    var item: FinancesModel
    
    // MARK: - ТЕЛО
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            
            // Иконка
            Text(item.category.image)
                .font(SetupFont.footnote())
                .frame(width: 40, height: 40, alignment: .center)
                .background(.black.opacity(0.1))
                .clipShape(Circle())
            
            // Текст и категория
            VStack(alignment: .leading, spacing: 4) {
                Text(LocalizedStringKey(item.category.locKey))
                    .font(SetupFont.callout())
                
                Text(LocalizedStringKey(item.type.rawValue))
                    .font(SetupFont.footnote())
            }
            .foregroundColor(.black)
            
            Spacer()
            
            // Цена
            Text(item.type == .minus ? "-\(item.amount.formattedWithSeparator)₽" : "+\(item.amount.formattedWithSeparator)₽")
                .font(SetupFont.title3())
                .foregroundColor(item.type == .minus ? .red : .green)
                .shadow(color: item.type == .minus ? .red.opacity(0.1) : .green.opacity(0.1), radius: 10, x: 0, y: 5)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        .onTapGesture {
            withAnimation(.spring()) {
                DispatchQueue.main.async {
                    viewModel.currentItemForDetailedInformation = item
                }
                viewModel.showDetailedInformation.toggle()
            }
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct OperationCell_Previews: PreviewProvider {
    static var previews: some View {
        MainOperationCell(item: FinancesModel(type: .minus, amount: 100, category: CategoryModel(title: "Продукты", image: "🥬", locKey: "protucts"), date: Date()))
            .previewLayout(.sizeThatFits)
    }
}

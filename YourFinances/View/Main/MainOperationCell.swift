//
//  OperationCell.swift
//  YourFinances
//
//  Created by Максим Боталов on 15.12.2022.
//

import SwiftUI

struct MainOperationCell: View {
    
    @ObservedObject var viewModel: FinancesViewModel
    var item: FinancesModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Text(item.category.image)
                .font(SetupFont.footnote())
                .frame(width: 40, height: 40, alignment: .center)
                .background(Color.black.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(LocalizedStringKey(item.category.locKey))
                    .font(SetupFont.callout())
                
                Text(LocalizedStringKey(item.type.rawValue))
                    .font(SetupFont.footnote())
            }
            
            Spacer()
            
            Text(item.type == .minus ? "-\(item.amount.formattedWithSeparator)₽" : "+\(item.amount.formattedWithSeparator)₽")
                .font(SetupFont.title3())
                .foregroundColor(item.type == .minus ? .red : .green)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
        .onTapGesture {
            viewModel.currentItemForDetailedInformation = item
            viewModel.showDetailedInformation.toggle()
        }
    }
}

struct OperationCell_Previews: PreviewProvider {
    static var previews: some View {
        MainOperationCell(viewModel: FinancesViewModel(), item: FinancesModel(type: .minus, amount: 100, category: CategoryModel(title: "Продукты", image: "🥬", locKey: "protucts"), date: Date()))
            .previewLayout(.sizeThatFits)
    }
    
}

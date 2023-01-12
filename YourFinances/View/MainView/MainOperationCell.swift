//
//  OperationCell.swift
//  YourFinances
//
//  Created by Максим Боталов on 15.12.2022.
//

import SwiftUI
import ToastUI

struct MainOperationCell: View {
    
    @ObservedObject var viewModel: FinancesViewModel
    var item: FinancesModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Text(item.category.image)
                .frame(width: 48, height: 48, alignment: .center)
                .background(Color.black.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 5) {
                Text(item.category.title)
                    .font(SetupFont.callout())
                
                Text(item.type.rawValue)
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
            viewModel.currentItem = item
            viewModel.showItem = true
        }
        
        .toast(isPresented: $viewModel.showItem) {
            MainDescriptionOperationView(viewModel: viewModel)
                .padding(16)
        }
    }
}

struct OperationCell_Previews: PreviewProvider {
    static var previews: some View {
        MainOperationCell(viewModel: FinancesViewModel(), item: FinancesModel(type: .minus, amount: 100, category: CategoryModel(title: "Продукты", image: "🥬"), description: ""))
            .previewLayout(.sizeThatFits)
    }
    
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}

//
//  DescriptionItemView.swift
//  YourFinances
//
//  Created by Максим Боталов on 27.12.2022.
//

import SwiftUI

struct MainDescriptionOperationView: View {
    
    @ObservedObject var viewModel: FinancesViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: viewModel.currentItem.description == "" ?  0 : 16) {
            HStack(alignment: .center, spacing: 10) {
                Text(viewModel.currentItem.category.image)
                    .frame(minWidth: 48, minHeight: 48)
                    .background(Color.black.opacity(0.1))
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.currentItem.category.title)
                        .font(SetupFont.callout())
                    
                    Text(viewModel.currentItem.type.rawValue)
                        .font(SetupFont.footnote())
                }
                
                Spacer()
                
                Text(viewModel.currentItem.type == .minus ? "-\(viewModel.currentItem.amount.formattedWithSeparator)₽" : "+\(viewModel.currentItem.amount.formattedWithSeparator)₽")
                    .font(SetupFont.title3())
                    .foregroundColor(viewModel.currentItem.type == .minus ? .red : .green)
            }
            
            Text(viewModel.currentItem.description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(SetupFont.footnote())
            
            HStack {
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.deleteItem(item: viewModel.currentItem)
                        viewModel.showItem = false
                    }
                } label: {
                    Text("Удалить")
                        .font(SetupFont.footnoteButton())
                        .frame(maxWidth: .infinity)
                        .frame(height: 32)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .clipShape(Capsule(style: .continuous))
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                }
                
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.showItem = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(SetupFont.footnoteButton())
                        .frame(width: 80, height: 32)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .clipShape(Capsule(style: .continuous))
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
    }
}

struct DescriptionItemView_Previews: PreviewProvider {
    static var previews: some View {
        MainDescriptionOperationView(viewModel: FinancesViewModel())
            .previewLayout(.sizeThatFits)
    }
}

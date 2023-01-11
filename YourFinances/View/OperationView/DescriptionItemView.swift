//
//  DescriptionItemView.swift
//  YourFinances
//
//  Created by Максим Боталов on 27.12.2022.
//

import SwiftUI

struct DescriptionItemView: View {
    
    @ObservedObject var viewModel: FinancesViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: viewModel.currentItem.description == "" ?  0 : 16) {
            HStack(alignment: .center, spacing: 10) {
                Text(viewModel.currentItem.category.image)
                    .frame(minWidth: 50, minHeight: 50)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.currentItem.category.title)
                        .font(.system(size: 16, weight: .semibold, design: .default))
                    
                    Text(viewModel.currentItem.type.rawValue)
                        .font(.system(size: 12, weight: .regular, design: .default))
                }
                
                Spacer()
                
                Text(viewModel.currentItem.type == .minus ? "-\(viewModel.currentItem.amount.formattedWithSeparator)₽" : "+\(viewModel.currentItem.amount.formattedWithSeparator)₽")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(viewModel.currentItem.type == .minus ? .red : .green)
                
                
            }
            
            Text(viewModel.currentItem.description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14, weight: .regular, design: .default))
            
            HStack {
                Button {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        viewModel.deleteItem(item: viewModel.currentItem)
                        viewModel.showItem = false
                    }
                } label: {
                    Text("Удалить")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .clipShape(Capsule(style: .continuous))
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                }
                
                Button {
                    // Тут будет переход на страницу редактирования
                } label: {
                    Image(systemName: "pencil")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .clipShape(Capsule(style: .continuous))
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                }
                
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.showItem = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .frame(width: 40, height: 40)
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
        DescriptionItemView(viewModel: FinancesViewModel())
    }
}

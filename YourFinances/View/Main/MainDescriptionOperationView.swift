//
//  DescriptionItemView.swift
//  YourFinances
//
//  Created by Максим Боталов on 27.12.2022.
//

import SwiftUI

struct MainDescriptionOperationView: View {
    
    // MARK: - СВОЙСТВА
    @EnvironmentObject var viewModel: FinancesViewModel
    
    // MARK: - ТЕЛО
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center, spacing: 10) {
                
                // Иконка
                Text(viewModel.currentItemForDetailedInformation.category.image)
                    .frame(minWidth: 48, minHeight: 48)
                    .background(.black.opacity(0.1))
                    .clipShape(Circle())
                
                // Описание
                VStack(alignment: .leading, spacing: 5) {
                    Text(LocalizedStringKey(viewModel.currentItemForDetailedInformation.category.title.lowercased()))
                        .font(SetupFont.callout())
                    
                    Text(LocalizedStringKey(viewModel.currentItemForDetailedInformation.type.rawValue))
                        .font(SetupFont.footnote())
                }
                .foregroundColor(.black)
                
                Spacer()
                
                // Сумма
                Text(viewModel.currentItemForDetailedInformation.type == .minus ? "-\(viewModel.currentItemForDetailedInformation.amount.formattedWithSeparator)₽" : "+\(viewModel.currentItemForDetailedInformation.amount.formattedWithSeparator)₽")
                    .font(SetupFont.title3())
                    .foregroundColor(viewModel.currentItemForDetailedInformation.type == .minus ? .red : .green)
                    .shadow(color: viewModel.currentItemForDetailedInformation.type == .minus ? .red.opacity(0.1) : .green.opacity(0.1), radius: 10, x: 0, y: 5)
            }
            
            // Кнопки
            HStack {
                // Удаление
                Button {
                    withAnimation(.spring()) {
                        viewModel.deleteItem(item: viewModel.currentItemForDetailedInformation)
                        viewModel.showDetailedInformation = false
                    }
                } label: {
                    HStack(alignment: .center, spacing: 8) {
                        Image(systemName: "trash")
                            .font(SetupFont.footnoteButton())
                        
                        Text(Localizable.delete)
                            .font(SetupFont.footnoteButton())

                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .clipShape(Capsule(style: .continuous))
                    .shadow(color: .red.opacity(0.1), radius: 10, x: 0, y: 5)
                }
                
                // Кнопка закрытия
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.showDetailedInformation = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(SetupFont.footnoteButton())
                        .frame(width: 80, height: 32)
                        .foregroundColor(.black)
                        .background(SetupColor.white)
                        .overlay(content: {
                            Capsule(style: .continuous)
                                .stroke(lineWidth: 3)
                                .foregroundColor(.black)
                        })
                        .clipShape(Capsule(style: .continuous))
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                }
            }
        }
        .padding(16)
        .background(.white)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct DescriptionItemView_Previews: PreviewProvider {
    static var previews: some View {
        MainDescriptionOperationView()
            .previewLayout(.sizeThatFits)
            .environmentObject(FinancesViewModel())
    }
}

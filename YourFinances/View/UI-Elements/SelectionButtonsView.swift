//
//  SelectionButtonsView.swift
//  YourFinances
//
//  Created by Максим Боталов on 26.01.2023.
//

import SwiftUI

struct SelectionButtonsView: View {
    
    // MARK: - СВОЙСТВА
    @Binding var isExpense: Bool
    
    // MARK: - ТЕЛО
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            
            // Левая кнопка
            Button {
                withAnimation(.spring()) {
                    isExpense = true
                }
            } label: {
                HStack(alignment: .center, spacing: 16) {
                    Image(systemName: "arrow.down")
                        .foregroundColor(.red)
                    Text(Localizable.expense)
                }
                .font(SetupFont.callout())
                .frame(maxWidth: .infinity)
                .frame(height: 32)
                .foregroundColor(isExpense ? .white : .black)
                .background(isExpense ? .black : .white)
                .clipShape(Capsule(style: .continuous))
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            }
            
            // Правая кнопка
            Button {
                withAnimation(.spring()) {
                    isExpense = false
                }
            } label: {
                HStack(alignment: .center, spacing: 16) {
                    Image(systemName: "arrow.up")
                        .foregroundColor(.green)
                    Text(Localizable.profit)
                }
                .font(SetupFont.callout())
                .frame(maxWidth: .infinity)
                .frame(height: 32)
                .foregroundColor(isExpense ? .black : .white)
                .background(isExpense ? .white: .black)
                .clipShape(Capsule(style: .continuous))
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            }
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct SelectionButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionButtonsView(isExpense: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}

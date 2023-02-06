//
//  NoOperationsView.swift
//  YourFinances
//
//  Created by Максим Боталов on 19.01.2023.
//

import SwiftUI

struct NoOperationsView: View {
    
    // MARK: - СВОЙСТВА
    @State private var isPresentedNewExpense = false

    // MARK: - ТЕЛО
    var body: some View {
        
        // Заголовок
        VStack(alignment: .center, spacing: 20) {
            Text(Localizable.noOperations)
                .modifier(CustomText(font: SetupFont.title3(), color: .black))
            
            // Кнопка, которая переправляет на NewOperationView
            Button {
                isPresentedNewExpense = true
            } label: {
                HStack(alignment: .center, spacing: 16) {
                    Image(systemName: "plus")
                    Text(Localizable.addNew)
                }
                .modifier(CustomButton(font: SetupFont.footnoteButton(), background: .blue, foreground: .white, height: 32, maxWidth: 200))
            }
            
            // Переход на создание новой операции
            .sheet(isPresented: $isPresentedNewExpense) {
                NewOperationView()
            }
        }
        .padding(40)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct NoOperationsView_Previews: PreviewProvider {
    static var previews: some View {
        NoOperationsView()
            .previewLayout(.sizeThatFits)
    }
}

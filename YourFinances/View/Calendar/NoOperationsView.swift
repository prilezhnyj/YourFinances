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
        
        // MARK: Заголовок
        VStack(alignment: .center, spacing: 20) {
            Text(Localizable.noOperations)
                .font(SetupFont.title3())
                .foregroundColor(SetupColor.white)
            
            // MARK: Кнопка, которыя переправляет на NewOperationView
            Button {
                isPresentedNewExpense.toggle()
            } label: {
                Text(Localizable.addNew)
                    .font(SetupFont.footnoteButton())
                    .frame(width: 150, height: 32)
                    .background(SetupColor.blue)
                    .foregroundColor(SetupColor.white)
                    .clipShape(Capsule(style: .continuous))
                    .shadow(color: SetupColor.blue.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            // MARK: Переход на создание новой операции
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

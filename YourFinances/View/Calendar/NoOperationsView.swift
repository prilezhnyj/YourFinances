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
        VStack(alignment: .center, spacing: 16) {
            Text(Localizable.noOperations)
                .font(SetupFont.title3())
            
            // MARK: Кнопка, которыя переправляет на NewOperationView
            Button {
                isPresentedNewExpense.toggle()
            } label: {
                Text(Localizable.addNew)
                    .font(SetupFont.footnoteButton())
                    .frame(width: 150, height: 32)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .clipShape(Capsule(style: .continuous))
                    .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 0)
            }
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

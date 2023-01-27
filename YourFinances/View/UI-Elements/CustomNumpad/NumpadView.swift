//
//  NumPadView.swift
//  YourFinances
//
//  Created by Максим Боталов on 08.01.2023.
//

import SwiftUI

struct NumPadView: View {
    // MARK: - СВОЙСТВА
    @EnvironmentObject var viewModel: FinancesViewModel
    
    // MARK: - ТЕЛО
    var body: some View {
        VStack(spacing: 8) {
            KeyPad(string: $viewModel.operationAmount)
            
            Button("Закрыть") {
                withAnimation(.spring()) {
                    viewModel.showNumpadView = false
                }
            }
            .modifier(CustomButton(font: SetupFont.callout(), background: .clear, foreground: .red, height: 32, maxWidth: .infinity))
        }
        .padding(16)
        .background(SetupColor.secondary)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct NumpadView_Previews: PreviewProvider {
    static var previews: some View {
        NumPadView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .environmentObject(FinancesViewModel())
    }
}

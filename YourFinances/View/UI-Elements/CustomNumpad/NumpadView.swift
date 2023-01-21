//
//  NumPadView.swift
//  YourFinances
//
//  Created by Максим Боталов on 08.01.2023.
//

import SwiftUI

struct NumPadView: View {
    // MARK: - СВОЙСТВА
    @ObservedObject var viewModel: FinancesViewModel
    
    // MARK: - ТЕЛО
    var body: some View {
        VStack(spacing: 8) {
            KeyPad(string: $viewModel.operationAmount)
        }
        .padding(16)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct NumpadView_Previews: PreviewProvider {
    static var previews: some View {
        NumPadView(viewModel: FinancesViewModel())
            .previewLayout(.sizeThatFits)
    }
}

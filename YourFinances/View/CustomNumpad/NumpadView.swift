//
//  NumpadView.swift
//  YourFinances
//
//  Created by Максим Боталов on 08.01.2023.
//

import SwiftUI

struct NumpadView: View {
    @ObservedObject var viewModel: FinancesViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            KeyPad(string: $viewModel.operationAmount)
                .padding(16)
            
            Button {
                viewModel.isPresentedNumpadView = false
            } label: {
                Text("Закрыть панель ввода")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 16)
            }
        }
    }
}

struct NumpadView_Previews: PreviewProvider {
    static var previews: some View {
        NumpadView(viewModel: FinancesViewModel())
            .previewLayout(.sizeThatFits)
    }
}

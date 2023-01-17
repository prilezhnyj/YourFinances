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
        VStack(spacing: 8) {
            KeyPad(string: $viewModel.operationAmount)
                .padding(16)
            
            Button {
                viewModel.showNumpadView = false
            } label: {
                Text("Close numpad")
                    .font(SetupFont.footnoteButton())
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

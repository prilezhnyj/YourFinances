//
//  WidgetProgressBarView.swift
//  YourFinances
//
//  Created by Максим Боталов on 12.01.2023.
//

import SwiftUI

struct WidgetProgressBarView: View {
    @ObservedObject var viewModel: FinancesViewModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule(style: .continuous)
                .foregroundColor(Color.black.opacity(0.1))
                
            Capsule(style: .continuous)
                .fill(LinearGradient(gradient: .init(colors: [.purple, .blue]), startPoint: .leading, endPoint: .trailing))
                .frame(maxWidth: getWidthFromPercentage() >= 0 ? getWidthFromPercentage() : 1, maxHeight: 16)
                .opacity(getWidthFromPercentage() >= 0 ? 1 : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: 16)
        .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5), value: viewModel.getPercentageTotalAmount())
    }
    
    func getWidthFromPercentage() -> CGFloat {
        let width = UIScreen.main.bounds.width - 64
        return width * viewModel.getPercentageTotalAmount()
    }
}

struct WidgetProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetProgressBarView(viewModel: FinancesViewModel())
            .previewLayout(.sizeThatFits)
    }
}

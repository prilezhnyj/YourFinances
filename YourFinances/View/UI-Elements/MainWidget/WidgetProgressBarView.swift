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
        GeometryReader { proxy in
            ZStack(alignment: .bottomLeading) {
                Text(viewModel.minusArray.isEmpty && viewModel.plusArray.isEmpty ? "" : "🔻")
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                    .offset(x: proxy.size.width * CGFloat(viewModel.getSum(for: viewModel.minusArray) / viewModel.getSum(for: viewModel.plusArray)), y: -2)
                
                Capsule(style: .continuous)
                    .frame(height: 5)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.linearGradient(Gradient(colors: [.red, .green]), startPoint: .trailing, endPoint: .leading))
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 20)
    }
}

struct WidgetProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetProgressBarView(viewModel: FinancesViewModel())
            .previewLayout(.sizeThatFits)
    }
}

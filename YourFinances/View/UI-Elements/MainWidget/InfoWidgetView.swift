//
//  InfoWidgetView.swift
//  YourFinances
//
//  Created by Максим Боталов on 11.01.2023.
//

import SwiftUI

struct InfoWidgetView: View {
    @ObservedObject var viewModel: FinancesViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("За " + viewModel.getTitleMonth(for: viewModel.currentDay))
                            .font(SetupFont.title2())
                        Text("вы сэкономили")
                            .font(SetupFont.footnote())
                    }
                    Text(viewModel.savedSum(for: viewModel.plusArray, and: viewModel.minusArray).formattedWithSeparator + "₽")
                        .font(SetupFont.title2())
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Заработали")
                            .font(SetupFont.footnote())
                        Text(viewModel.getSum(for: viewModel.plusArray).formattedWithSeparator + "₽")
                            .font(SetupFont.callout())
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Потратили")
                            .font(SetupFont.footnote())
                        Text(viewModel.getSum(for: viewModel.minusArray).formattedWithSeparator + "₽")
                            .font(SetupFont.callout())
                    }
                }
            }
            
            WidgetProgressBarView(viewModel: viewModel)
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
    }
}

struct InfoWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        InfoWidgetView(viewModel: FinancesViewModel())
            .previewLayout(.sizeThatFits)
    }
}

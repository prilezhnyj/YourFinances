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
                        Text("For " + viewModel.getTitleMonth(for: viewModel.currentDay))
                            .font(SetupFont.title2())
                        Text("you have saved")
                            .font(SetupFont.footnote())
                    }
                    Text(viewModel.savedSum(for: viewModel.profitsArray, and: viewModel.expenseArray).formattedWithSeparator + "₽")
                        .font(SetupFont.title2())
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Earned")
                            .font(SetupFont.footnote())
                        Text(viewModel.getSum(for: viewModel.profitsArray).formattedWithSeparator + "₽")
                            .font(SetupFont.callout())
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Spent")
                            .font(SetupFont.footnote())
                        Text(viewModel.getSum(for: viewModel.expenseArray).formattedWithSeparator + "₽")
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

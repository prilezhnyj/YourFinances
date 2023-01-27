//
//  InfoWidgetView.swift
//  YourFinances
//
//  Created by Максим Боталов on 11.01.2023.
//

import SwiftUI

struct InfoWidgetView: View {
    
    // MARK: - СВОЙСТВА
    @EnvironmentObject var viewModel: FinancesViewModel
    
    // MARK: - ТЕЛО
    var body: some View {
        allView()
    }
    
    // MARK: - ФУНКЦИИ && UI
    
    // Информация слева
    private func informationLeft() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // Месяц
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 4) {
                    Text(Localizable.forMonth).font(SetupFont.title2())
                    Text(Localizable.month).font(SetupFont.title2())
                }
                
                Text(Localizable.youHaveSaved)
                    .font(SetupFont.footnote())
            }
            
            // Сумма
            Text(viewModel.getGapBetweenAmounts(for: viewModel.profitsArray, and: viewModel.expenseArray).formattedWithSeparator + "₽")
                .font(SetupFont.title2())
        }
    }
    
    // Информация справа
    private func informationRight() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // Заработали
            VStack(alignment: .leading, spacing: 0) {
                Text(Localizable.earned)
                    .font(SetupFont.footnote())
                
                Text(viewModel.getAmount(for: viewModel.profitsArray).formattedWithSeparator + "₽")
                    .font(SetupFont.callout())
            }
            
            // Потратили
            VStack(alignment: .leading, spacing: 0) {
                Text(Localizable.spent)
                    .font(SetupFont.footnote())

                Text(viewModel.getAmount(for: viewModel.expenseArray).formattedWithSeparator + "₽")
                    .font(SetupFont.callout())
            }
        }
    }
    
    // Информация объединенная
    private func allView() -> some View {
        VStack(spacing: 16) {
            HStack(alignment: .top) {
                informationLeft()
                Spacer()
                informationRight()
            }
            .foregroundColor(.white)
            
            WidgetProgressBarView()
        }
        .padding(16)
        .background(SetupColor.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: SetupColor.secondary.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct InfoWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        InfoWidgetView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .environmentObject(FinancesViewModel())
    }
}

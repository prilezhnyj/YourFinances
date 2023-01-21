//
//  InfoWidgetView.swift
//  YourFinances
//
//  Created by Максим Боталов on 11.01.2023.
//

import SwiftUI

struct InfoWidgetView: View {
    
    // MARK: - СВОЙСТВА
    @ObservedObject var viewModel: FinancesViewModel
    
    // MARK: - ТЕЛО
    var body: some View {
        allView()
    }
    
    // MARK: - ФУНКЦИИ && UI
    
    // MARK: Информация слева
    func informationLeft() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // MARK: Месяц
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 4) {
                    Text(Localizable.forMonth).font(SetupFont.title2())
                    Text(Localizable.month).font(SetupFont.title2())
                }
                Text(Localizable.youHaveSaved)
                    .font(SetupFont.footnote())
            }
            
            // MARK: Сумма
            Text(viewModel.getGapBetweenAmounts(for: viewModel.profitsArray, and: viewModel.expenseArray).formattedWithSeparator + "₽")
                .font(SetupFont.title2())
        }
    }
    
    // MARK: Информация справа
    func informationRight() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // MARK: Заработали
            VStack(alignment: .leading, spacing: 0) {
                Text(Localizable.earned)
                    .font(SetupFont.footnote())
                
                Text(viewModel.getAmount(for: viewModel.profitsArray).formattedWithSeparator + "₽")
                    .font(SetupFont.callout())
            }
            
            // MARK: Потратили
            VStack(alignment: .leading, spacing: 0) {
                Text(Localizable.spent)
                    .font(SetupFont.footnote())

                Text(viewModel.getAmount(for: viewModel.expenseArray).formattedWithSeparator + "₽")
                    .font(SetupFont.callout())
            }
        }
    }
    
    // MARK: Информация объединенная
    func allView() -> some View {
        VStack(spacing: 16) {
            HStack(alignment: .top) {
                informationLeft()
                Spacer()
                informationRight()
            }
            
            WidgetProgressBarView(viewModel: viewModel)
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct InfoWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        InfoWidgetView(viewModel: FinancesViewModel())
            .previewLayout(.sizeThatFits)
    }
}

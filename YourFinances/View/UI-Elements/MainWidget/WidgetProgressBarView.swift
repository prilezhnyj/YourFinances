//
//  WidgetProgressBarView.swift
//  YourFinances
//
//  Created by Максим Боталов on 12.01.2023.
//

import SwiftUI

struct WidgetProgressBarView: View {
    
    // MARK: - СВОЙСТВА
    @EnvironmentObject var viewModel: FinancesViewModel
    
    // MARK: - ТЕЛО
    var body: some View {
        widgetProgressBarView()
    }
    
    // MARK: - ФУНКЦИИ && UI
    // Общая View
    private func widgetProgressBarView() -> some View {
        ZStack(alignment: .leading) {
            lowerView()
            upperView()

        }
        .frame(maxWidth: .infinity, maxHeight: 16)
        .animation(.easeInOut(duration: 0.2), value: viewModel.getPercentageTotalAmount())
    }
    
    // Верхняя View
    private func upperView() -> some View {
        Capsule(style: .continuous)
            .fill(LinearGradient(gradient: .init(colors: [.red, .green]), startPoint: .leading, endPoint: .trailing))
            .frame(maxWidth: getWidthFromPercentage() >= 0 ? getWidthFromPercentage() : 1, maxHeight: 16)
            .opacity(getWidthFromPercentage() >= 0 ? 1 : 0)
    }
    
    // Нижняя View
    private func lowerView() -> some View {
        Capsule(style: .continuous)
            .foregroundColor(.black.opacity(0.1))
    }
    
    // Расчёт процентов и перевод в CGFloat
    private func getWidthFromPercentage() -> CGFloat {
        let width = UIScreen.main.bounds.width - 64
        return width * viewModel.getPercentageTotalAmount()
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct WidgetProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetProgressBarView()
            .previewLayout(.sizeThatFits)
            .environmentObject(FinancesViewModel())
    }
}

//
//  FullWeekView.swift
//  YourFinances
//
//  Created by Максим Боталов on 13.01.2023.
//

import SwiftUI

struct FullWeekView: View {
    
    // MARK: - СВОЙСТВА
    @ObservedObject var viewModel: FinancesViewModel
    
    // MARK: - ТЕЛО
    var body: some View {
        fullWeekView()
    }
    
    // MARK: - ФУНКЦИИ && UI
    private func fullWeekView() -> some View {
        HStack(alignment: .center, spacing: 8) {
            
            // MARK: ForEach, для раскидывания недели
            ForEach(viewModel.currentWeek, id: \.self) { day in
                OneDayView(dayWeek: viewModel.extractDate(for: day, format: "dd"), titleDayWeek: viewModel.extractDate(for: day, format: "EE"), isToday: viewModel.isToday(for: day))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.selectedDayWeek = day
                        }
                    }
                    .overlay(Capsule(style: .continuous).stroke(viewModel.selectedDayWeek == day ? .black : .clear , lineWidth: 2))
            }
        }
        // MARK: Смена курсора на выбранный день
        .onChange(of: viewModel.selectedDayWeek) { newValue in
            viewModel.filterOperationsDay()
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct DaysScrollView_Previews: PreviewProvider {
    static var previews: some View {
        FullWeekView(viewModel: FinancesViewModel())
            .previewLayout(.sizeThatFits)
    }
}

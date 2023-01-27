//
//  FullWeekView.swift
//  YourFinances
//
//  Created by Максим Боталов on 13.01.2023.
//

import SwiftUI

struct FullWeekView: View {
    
    // MARK: - СВОЙСТВА
    @EnvironmentObject var viewModel: FinancesViewModel
    
    // MARK: - ТЕЛО
    var body: some View {
        fullWeekView()
    }
    
    // MARK: - ФУНКЦИИ && UI
    private func fullWeekView() -> some View {
        HStack(alignment: .center, spacing: 8) {
            
            // ForEach, для раскидывания недели
            ForEach(viewModel.currentWeek, id: \.self) { day in
                OneDayView(dayWeek: viewModel.extractDate(for: day, format: "dd"), titleDayWeek: viewModel.extractDate(for: day, format: "EE"), isToday: viewModel.isToday(for: day))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            viewModel.selectedDayWeek = day
                        }
                    }
                    .overlay(
                        Capsule(style: .continuous).stroke(viewModel.selectedDayWeek == day ? .white : .clear , lineWidth: 2)
                            .shadow(color: viewModel.selectedDayWeek == day ? .white.opacity(0.3) : SetupColor.secondary.opacity(0.3), radius: 10, x: 0, y: 5)
                    )
            }
        }
        // Смена курсора на выбранный день
        .onChange(of: viewModel.selectedDayWeek) { newValue in
            viewModel.filterOperationsDay()
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct DaysScrollView_Previews: PreviewProvider {
    static var previews: some View {
        FullWeekView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .environmentObject(FinancesViewModel())
    }
}

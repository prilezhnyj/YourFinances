//
//  FullWeekView.swift
//  YourFinances
//
//  Created by Максим Боталов on 13.01.2023.
//

import SwiftUI

struct FullWeekView: View {
    @ObservedObject var viewModel: FinancesViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
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
        .padding(.horizontal, 16)
        .onChange(of: viewModel.selectedDayWeek) { newValue in
            viewModel.filtredToday()
        }
    }
}

struct DaysScrollView_Previews: PreviewProvider {
    static var previews: some View {
        FullWeekView(viewModel: FinancesViewModel())
            .previewLayout(.sizeThatFits)
    }
}

//
//  OneDayView.swift
//  YourFinances
//
//  Created by Максим Боталов on 13.01.2023.
//

import SwiftUI

struct OneDayView: View {
    @ObservedObject var viewModel: FinancesViewModel
    
    @State var dayWeek: String
    @State var dayMonth: String
    @State var isToday: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(dayWeek)
                .font(SetupFont.footnote())
                .foregroundColor(isToday ? .white : .black)
            
            Text(dayMonth)
                .font(SetupFont.footnoteButton())
                .foregroundColor(isToday ? .white : .black)
            
            Circle()
                .foregroundColor(isToday ? .white : .black)
                .frame(width: 8, height: 8, alignment: .center)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 64, alignment: .center)
        .background(isToday ? .black : .white)
        .clipShape(Capsule(style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
    }
}

struct OneDayView_Previews: PreviewProvider {
    static var previews: some View {
        OneDayView(viewModel: FinancesViewModel(), dayWeek: "Пт", dayMonth: "09", isToday: true)
            .previewLayout(.sizeThatFits)
    }
}

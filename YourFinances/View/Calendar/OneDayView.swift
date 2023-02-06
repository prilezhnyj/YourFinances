//
//  OneDayView.swift
//  YourFinances
//
//  Created by Максим Боталов on 13.01.2023.
//

import SwiftUI

struct OneDayView: View {
    
    // MARK: - СВОЙСТВА
    let dayWeek: String
    let titleDayWeek: String
    let isToday: Bool
    
    // MARK: - ТЕЛО
    var body: some View {
        
        // Один день
        VStack(alignment: .center, spacing: 4) {
            
            // Краткое название недели
            Text(titleDayWeek.capitalized)
                .font(SetupFont.footnote())
            
            // Число месяца
            Text(dayWeek)
                .font(SetupFont.footnoteButton())
        }
        .frame(maxWidth: .infinity, maxHeight: 56, alignment: .center)
        .foregroundColor(isToday ? .white : .black)
        .background(isToday ? .black : .white)
        .clipShape(Capsule(style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct OneDayView_Previews: PreviewProvider {
    static var previews: some View {
        OneDayView(dayWeek: "9", titleDayWeek: "Пт", isToday: false)
            .previewLayout(.sizeThatFits)
    }
}

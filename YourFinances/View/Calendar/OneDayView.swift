//
//  OneDayView.swift
//  YourFinances
//
//  Created by Максим Боталов on 13.01.2023.
//

import SwiftUI

struct OneDayView: View {
    
    // MARK: - СВОЙСТВА
    @State var dayWeek: String
    @State var titleDayWeek: String
    @State var isToday: Bool
    
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
        .foregroundColor(isToday ? SetupColor.secondary : .white)
        .background(isToday ? .white : SetupColor.secondary)
        .clipShape(Capsule(style: .continuous))
        .shadow(color: isToday ? .white.opacity(0.3) : SetupColor.secondary.opacity(0.3), radius: 5, x: 0, y: 5)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct OneDayView_Previews: PreviewProvider {
    static var previews: some View {
        OneDayView(dayWeek: "9", titleDayWeek: "Пт", isToday: false)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}

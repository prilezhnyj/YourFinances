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
        
        // MARK: ОДИН ДЕНЬ ИЗ НЕДЕЛЬНОГО КАЛЕНДАРЯ
        VStack(alignment: .center, spacing: 4) {
            
            // MARK: Краткое название недели
            Text(titleDayWeek.capitalized)
                .font(SetupFont.footnote())
                .foregroundColor(isToday ? .white : .black)
            
            // MARK: Число месяца
            Text(dayWeek)
                .font(SetupFont.footnoteButton())
                .foregroundColor(isToday ? .white : .black)
        }
        .frame(maxWidth: .infinity, maxHeight: 52, alignment: .center)
        .background(isToday ? .black : .white)
        .clipShape(Capsule(style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct OneDayView_Previews: PreviewProvider {
    static var previews: some View {
        OneDayView(dayWeek: "9", titleDayWeek: "Пт", isToday: false)
            .previewLayout(.sizeThatFits)
    }
}

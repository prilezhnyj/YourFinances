//
//  OneDayView.swift
//  YourFinances
//
//  Created by Максим Боталов on 13.01.2023.
//

import SwiftUI

struct OneDayView: View {
    @State var dayWeek: String
    @State var titleDayWeek: String
    @State var isToday: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text(titleDayWeek)
                .font(SetupFont.footnote())
                .foregroundColor(isToday ? .white : .black)
            
            Text(dayWeek)
                .font(SetupFont.footnoteButton())
                .foregroundColor(isToday ? .white : .black)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56, alignment: .center)
        .background(isToday ? .black : .white)
        .clipShape(Capsule(style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
    }
}

struct OneDayView_Previews: PreviewProvider {
    static var previews: some View {
        OneDayView(dayWeek: "9", titleDayWeek: "ПТ", isToday: false)
            .previewLayout(.sizeThatFits)
    }
}

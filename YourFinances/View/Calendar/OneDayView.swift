//
//  OneDayView.swift
//  YourFinances
//
//  Created by Максим Боталов on 13.01.2023.
//

import SwiftUI

struct OneDayView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("33")
                .font(SetupFont.title3())
                .foregroundColor(.white)
            
            Circle()
                .foregroundColor(.white)
                .frame(width: 8, height: 8, alignment: .center)
        }
        .frame(width: 48, height: 72, alignment: .center)
        .background(Color.black)
        .clipShape(Capsule(style: .continuous))
    }
}

struct OneDayView_Previews: PreviewProvider {
    static var previews: some View {
        OneDayView()
            .previewLayout(.sizeThatFits)
    }
}

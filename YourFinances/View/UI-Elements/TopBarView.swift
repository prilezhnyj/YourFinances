//
//  TopBarView.swift
//  YourFinances
//
//  Created by Максим Боталов on 16.12.2022.
//

import SwiftUI

import SwiftUI

struct TopBarView: View {
    
    // MARK: - СВОЙСТВА
    @EnvironmentObject var viewModel: FinancesViewModel
    
    // MARK: - ТЕЛО
    var body: some View {
        HStack(alignment: .top) {
            
            // MARK: Текущая дата (День недели + дата)
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.extractDate(for: viewModel.currentDay, format: "EEEE").capitalized)
                    .font(SetupFont.title2())
                Text(viewModel.extractDate(for: viewModel.currentDay, format: "d MMMM yyyy"))
                    .font(SetupFont.footnote())
            }
            .foregroundColor(SetupColor.white())
            .frame(maxHeight: 48)
            
            Spacer()
            
            // MARK: Изображение пользователя
            Image("Avatar")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 48, height: 48, alignment: .center)
                .clipShape(Circle())
                .shadow(color: SetupColor.secondary().opacity(0.3), radius: 10, x: 0, y: 5)
        }
        .frame(maxWidth: .infinity, maxHeight: 48)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
            .previewLayout(.sizeThatFits)
            .environmentObject(FinancesViewModel())
            .environment(\.colorScheme, .dark)
    }
}

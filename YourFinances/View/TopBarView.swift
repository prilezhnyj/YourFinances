//
//  TopBarView.swift
//  YourFinances
//
//  Created by Максим Боталов on 16.12.2022.
//

import SwiftUI

import SwiftUI

struct TopBarView: View {
    @ObservedObject var viewModel: FinancesViewModel
    
    var body: some View {
        HStack {
            // MARK: Текущая дата (День недели + дата)
            VStack(alignment: .leading) {
                Text(viewModel.getTitleWeekDay(for: viewModel.currentDay))
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                Text(viewModel.currentDay.formatted(date: .long, time: .omitted))
                    .font(.system(size: 16, weight: .regular, design: .default))
            }
            Spacer()
            
            Button {
                // Действие по кнопке
            } label: {
                Image("Avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50, alignment: .center)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 0)
            }
        }
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView(viewModel: FinancesViewModel())
            .previewLayout(.sizeThatFits)
    }
}

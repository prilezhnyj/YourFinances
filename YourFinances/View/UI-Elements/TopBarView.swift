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
        HStack(alignment: .top, spacing: 0) {
            // MARK: Текущая дата (День недели + дата)
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.extractDate(for: viewModel.currentDay, format: "EEEE").capitalized)
                    .font(SetupFont.title2())
                Text(viewModel.extractDate(for: viewModel.currentDay, format: "d MMMM yyyy"))
                    .font(SetupFont.footnote())
            }
            Spacer()
            
            Image("Avatar")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 48, height: 48, alignment: .center)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: 48)
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView(viewModel: FinancesViewModel())
            .previewLayout(.sizeThatFits)
    }
}

//
//  NoOperationsView.swift
//  YourFinances
//
//  Created by Максим Боталов on 19.01.2023.
//

import SwiftUI

struct NoOperationsView: View {
    @ObservedObject var viewModel: FinancesViewModel
    @State private var isPresentedNewExpense = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("No operations")
                .font(SetupFont.title3())
            
            Button {
                isPresentedNewExpense.toggle()
            } label: {
                Text("Add new")
                    .font(SetupFont.footnoteButton())
                    .frame(width: 150, height: 32)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .clipShape(Capsule(style: .continuous))
                    .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 0)
            }
            .sheet(isPresented: $isPresentedNewExpense) {
                NewOperationView(viewModel: viewModel)
            }
        }
        .padding(.top, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct NoOperationsView_Previews: PreviewProvider {
    static var previews: some View {
        NoOperationsView(viewModel: FinancesViewModel())
            .previewLayout(.sizeThatFits)
    }
}

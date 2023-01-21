//
//  ContentView.swift
//  YourFinances
//
//  Created by Максим Боталов on 13.12.2022.
//

import SwiftUI

struct NewOperationView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: FinancesViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            ScrollView(.vertical, showsIndicators: false) {
                Text(Localizable.newOperation)
                    .font(SetupFont.title3())
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 32)
                    .padding(.horizontal, 16)
                
                HStack(alignment: .center, spacing: 8) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.isExpense = true
                        }
                    } label: {
                        Text(Localizable.expense)
                            .font(SetupFont.callout())
                            .frame(maxWidth: .infinity)
                            .frame(height: 32)
                            .foregroundColor(viewModel.isExpense ? .white : .black)
                            .background(viewModel.isExpense ? Color.black : Color.white)
                            .clipShape(Capsule(style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                    }
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.isExpense = false
                        }
                    } label: {
                        Text(Localizable.profit)
                            .font(SetupFont.callout())
                            .frame(maxWidth: .infinity)
                            .frame(height: 32)
                            .foregroundColor(viewModel.isExpense ? .black : .white)
                            .background(viewModel.isExpense ? Color.white : Color.black)
                            .clipShape(Capsule(style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                    }
                    
                }
                .padding(.horizontal, 16)
                
                HStack(alignment: .center, spacing: 16) {
                    Text(Localizable.amount)
                        .font(SetupFont.title3())
                        .padding(.leading, 32)
                        .padding(.vertical, 16)
                    
                    Text(viewModel.operationAmount + "₽")
                        .foregroundColor(viewModel.operationAmount.isEmpty ? .black.opacity(0.5) : .black)
                        .font(SetupFont.title3())
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.black.opacity(0.1))
                        .clipShape(Capsule(style: .continuous))
                        .padding(16)
                        .onTapGesture {
                            viewModel.showNumpadView.toggle()
                        }
                }
                
                ShowCategoriesView(viewModel: viewModel)
                    .padding(.horizontal, 16)
                
                Button {
                    viewModel.saveOperation()
                    viewModel.operationAmount = ""
                    viewModel.showNumpadView = false
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text(Localizable.save)
                        .font(SetupFont.callout())
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(viewModel.operationAmount == "" ? Color.black.opacity(0.1) : Color.black)
                        .foregroundColor(viewModel.operationAmount == "" ? Color.black.opacity(0.5) : Color.white)
                        .clipShape(Capsule(style: .continuous))
                        .padding(16)
                        .shadow(color: .blue.opacity(0.1), radius: 10, x: 0, y: 0)
                }
                .disabled(viewModel.operationAmount == "" ? true : false)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(Localizable.info1)
                        .font(SetupFont.footnote())
                        .foregroundColor(.black.opacity(0.5))
                    
                    Text(Localizable.info2)
                        .font(SetupFont.footnote())
                        .foregroundColor(.black.opacity(0.5))
                    
                }
                .padding(.horizontal, 16)
                
            }
            
            if viewModel.showNumpadView {
                NumPadView(viewModel: viewModel)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                    .transition(.move(edge: .bottom))
                    .padding(16)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.showNumpadView)
    }
}

struct NewOperationView_Previews: PreviewProvider {
    static var previews: some View {
        NewOperationView(viewModel: FinancesViewModel())
    }
}

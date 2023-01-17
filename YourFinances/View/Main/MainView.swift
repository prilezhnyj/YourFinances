//
//  MainView.swift
//  YourFinances
//
//  Created by Максим Боталов on 14.12.2022.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = FinancesViewModel()
    @State private var isPresentedNewExpense = false
    @State private var isPresentedNewCategoryView = false
    
    var body: some View {
        ZStack(alignment: .center) {
                VStack(alignment: .center, spacing: 16) {
                    TopBarView(viewModel: viewModel)
                        .padding(.top ,16)
                        .padding(.horizontal, 16)
                    
                    InfoWidgetView(viewModel: viewModel)
                        .padding(.horizontal, 16)
                    
                    FullWeekView(viewModel: viewModel)
                    
                    if viewModel.currentExpenseArray.isEmpty && viewModel.currentProfitsArray.isEmpty {
                        NoOperationsView(viewModel: viewModel)
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            Section(header: HerderView(text: "Expenses", for: viewModel.currentExpenseArray)) {
                                ForEach(viewModel.currentExpenseArray) { item in
                                    MainOperationCell(viewModel: viewModel, item: item)
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding(.horizontal, 16)
                            }
                            
                            Section(header: HerderView(text: "Profits", for: viewModel.currentProfitsArray)) {
                                ForEach(viewModel.currentProfitsArray) { item in
                                    MainOperationCell(viewModel: viewModel, item: item)
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                }
            
            VStack {
                Spacer()
                HStack(alignment: .bottom, spacing: 8) {
                    Button {
                        isPresentedNewCategoryView.toggle()
                    } label: {
                        Text("Categories")
                            .font(SetupFont.footnoteButton())
                            .frame(maxWidth: .infinity, maxHeight: 32)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .clipShape(Capsule(style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 0)
                    }
                    .sheet(isPresented: $isPresentedNewCategoryView) {
                        NewCategoryView(viewModel: viewModel)
                    }
                    
                    Button {
                        //
                    } label: {
                        Text("Settings")
                            .font(SetupFont.footnoteButton())
                            .frame(maxWidth: .infinity, maxHeight: 32)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .clipShape(Capsule(style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 0)
                    }
                    
                    Spacer()
                    
                    Button {
                        isPresentedNewExpense.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 28, weight: .regular, design: .rounded))
                            .frame(width: 64, height: 64)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 0)
                    }
                    .sheet(isPresented: $isPresentedNewExpense) {
                        NewOperationView(viewModel: viewModel)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            }
        }
    }
    
    func HerderView(text: String, for array: [FinancesModel]) -> some View {
        HStack {
            Text(text)
                .font(SetupFont.callout())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .opacity(array.isEmpty ? 0 : 1)
            
            Spacer()
            
            Text(viewModel.getSum(for: array).formattedWithSeparator + "₽")
                .font(SetupFont.callout())
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 16)
                .opacity(array.isEmpty ? 0 : 1)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

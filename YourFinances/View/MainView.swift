//
//  MainView.swift
//  YourFinances
//
//  Created by Максим Боталов on 14.12.2022.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel = FinancesViewModel()
    @State var isPresentedNewExpense = false
    @State var isPresentedNewCategoryView = false
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .center, spacing: 16) {
                TopBarView(viewModel: viewModel)
                    .padding(16)
                
                InfoWidgetView(viewModel: viewModel)
                    .padding(.horizontal, 16)
                
                ScrollView(.vertical, showsIndicators: false) {
                    Section(header: HerderView(text: "Расходы", for: viewModel.minusArray)) {
                        ForEach(viewModel.minusArray) { item in
                            MainOperationCell(viewModel: viewModel, item: item)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 16)
                    }
                    
                    Section(header: HerderView(text: "Доходы", for: viewModel.plusArray)) {
                        ForEach(viewModel.plusArray) { item in
                            MainOperationCell(viewModel: viewModel, item: item)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 16)
                    }
                }
            }
            
            VStack {
                Spacer()
                HStack(alignment: .bottom, spacing: 8) {
                    Button {
                        isPresentedNewCategoryView.toggle()
                    } label: {
                        Text("Категории")
                            .font(.system(size: 14, weight: .semibold, design: .default))
                            .frame(maxWidth: .infinity, maxHeight: 40)
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
                        Text("Настройки")
                            .font(.system(size: 14, weight: .semibold, design: .default))
                            .frame(maxWidth: .infinity, maxHeight: 40)
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
                            .frame(width: 70, height: 70)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.4), radius: 20, x: 0, y: 0)
                    }
                    .sheet(isPresented: $isPresentedNewExpense) {
                        NewOperationView(viewModel: viewModel)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
    }
    
    func HerderView(text: String, for array: [FinancesModel]) -> some View {
        HStack {
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .padding(.horizontal, 16)
                .opacity(array.isEmpty ? 0 : 1)
            
            Spacer()
            
            Text(viewModel.getSum(for: array).formattedWithSeparator + "₽")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: 16, weight: .bold, design: .rounded))
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

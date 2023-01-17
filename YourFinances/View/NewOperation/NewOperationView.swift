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
        ZStack {
            Color.white
            
            ScrollView(.vertical, showsIndicators: false) {
                Text("New operation")
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
                        Text("Expense")
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
                        Text("Profit")
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
                
                Text(viewModel.operationAmount == "" ? "Operation amount" : viewModel.operationAmount + "₽")
                    .foregroundColor(viewModel.operationAmount == "" ? .black.opacity(0.5) : .black)
                    .font(SetupFont.title3())
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.black.opacity(0.1))
                    .clipShape(Capsule(style: .continuous))
                    .padding(16)
                    .onTapGesture {
                        viewModel.showNumpadView.toggle()
                    }
                
                ShowCategoriesView(viewModel: viewModel)
                    .padding(.horizontal, 16)
                
                // MARK: Описание операции. Когда-то реализую
                /*
                ZStack {
                    TextEditor(text: $viewModel.operationDescription)
                        .font(SetupFont.callout())
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .foregroundColor(.black)
                        .padding(16)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .focused($focusedField, equals: .operationDescription)
                        .submitLabel(.done)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                    
                    Text("Description of the note (optional)")
                        .font(SetupFont.callout())
                        .foregroundColor(viewModel.operationDescription == "" ? .black.opacity(0.1) : .clear)
                }
                .padding(16)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                */
                
                Button {
                    viewModel.saveOperation()
                    viewModel.operationAmount = ""
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Save")
                        .font(SetupFont.callout())
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(viewModel.operationAmount == "" ? Color.black.opacity(0.1) : Color.black)
                        .foregroundColor(viewModel.operationAmount == "" ? Color.black.opacity(0.5) : Color.white)
                        .clipShape(Capsule(style: .continuous))
                        .padding(16)
                        .shadow(color: .blue.opacity(0.1), radius: 10, x: 0, y: 0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5), value: viewModel.showAllCategories)
                }
                .disabled(viewModel.operationAmount == "" ? true : false)
                
            }
            .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5), value: viewModel.showAllCategories)
            
            // Нампад, который выезжает снизу
            VStack {
                Spacer()
                NumpadView(viewModel: viewModel)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                    .offset(y: viewModel.showNumpadView ? 0 : 100)
                    .opacity(viewModel.showNumpadView ? 1 : 0)
                    .animation(.easeInOut(duration: 0.3), value: viewModel.showNumpadView)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct NewOperationView_Previews: PreviewProvider {
    static var previews: some View {
        NewOperationView(viewModel: FinancesViewModel())
    }
}

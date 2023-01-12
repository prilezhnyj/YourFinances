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
    @FocusState private var focusedField: Field?
    
    private enum Field: Int, CaseIterable {
        case operationDescription
    }
    
    var body: some View {
        ZStack {
            Color.white
            
            ScrollView(.vertical, showsIndicators: false) {
                Text(viewModel.isMinus ? "Новый расход" : "Новый доход")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .padding(16)
                
                HStack(alignment: .center, spacing: 8) {
                    Button {
                        viewModel.isMinus = true
                    } label: {
                        Text("Расход")
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .frame(maxWidth: .infinity)
                            .frame(height: 34)
                            .foregroundColor(viewModel.isMinus ? .white : .black)
                            .background(viewModel.isMinus ? Color.black : Color.white)
                            .cornerRadius(48)
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                    }
                    Button {
                        viewModel.isMinus = false
                    } label: {
                        Text("Доход")
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .frame(maxWidth: .infinity)
                            .frame(height: 34)
                            .foregroundColor(viewModel.isMinus ? .black : .white)
                            .background(viewModel.isMinus ? Color.white : Color.black)
                            .cornerRadius(48)
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                    }
                    
                }
                .padding(.horizontal, 16)
                
                Text(viewModel.operationAmount == "" ? "Сумма покупки" : viewModel.operationAmount + "₽")
                    .foregroundColor(viewModel.operationAmount == "" ? . gray : .black)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding(.horizontal, 16)
                    .textFieldStyle(.plain)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(Capsule(style: .continuous))
                    .padding(16)
                    .onTapGesture {
                        viewModel.isPresentedNumpadView.toggle()
                    }
                
                ShowCategoriesView(viewModel: viewModel)
                    .padding(.horizontal, 16)
                
                ZStack {
                    TextEditor(text: $viewModel.operationDescription)
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundColor(.black)
                        .padding(16)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .focused($focusedField, equals: .operationDescription)
                        .submitLabel(.done)
                    
                    Text("Описание заметки (опицонально)")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundColor(viewModel.operationDescription == "" ? .gray : .clear)
                }
                .padding(16)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5), value: viewModel.showFullCategories)
                
                Button {
                    viewModel.saveOperation()
                    viewModel.operationAmount = ""
                    viewModel.operationDescription = ""
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Сохранить")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(viewModel.operationAmount == "" ? Color.gray.opacity(0.1) : Color.blue)
                        .foregroundColor(viewModel.operationAmount == "" ? Color.gray : Color.white)
                        .clipShape(Capsule())
                        .padding(.horizontal, 16)
                        .shadow(color: .blue.opacity(0.1), radius: 10, x: 0, y: 0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5), value: viewModel.showFullCategories)
                }
                .disabled(viewModel.operationAmount == "" ? true : false)
            }
            .onTapGesture {
                focusedField = nil
            }
            
            VStack {
                Spacer()
                NumpadView(viewModel: viewModel)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                    .offset(y: viewModel.isPresentedNumpadView ? 0 : 100)
                    .opacity(viewModel.isPresentedNumpadView ? 1 : 0)
                    .animation(.easeInOut(duration: 0.3), value: viewModel.isPresentedNumpadView)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
            }
        }
        .ignoresSafeArea(.container, edges: .bottom)
        
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewOperationView(viewModel: FinancesViewModel())
    }
}

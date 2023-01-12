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
            
            // Основное полотно
            ScrollView(.vertical, showsIndicators: false) {
                Text("Новая операция")
                    .font(SetupFont.title3())
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 32)
                    .padding(.horizontal, 16)
                
                HStack(alignment: .center, spacing: 8) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.isMinus = true
                        }
                    } label: {
                        Text("Расход")
                            .font(SetupFont.callout())
                            .frame(maxWidth: .infinity)
                            .frame(height: 32)
                            .foregroundColor(viewModel.isMinus ? .white : .black)
                            .background(viewModel.isMinus ? Color.black : Color.white)
                            .clipShape(Capsule(style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                    }
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.isMinus = false
                        }
                    } label: {
                        Text("Доход")
                            .font(SetupFont.callout())
                            .frame(maxWidth: .infinity)
                            .frame(height: 32)
                            .foregroundColor(viewModel.isMinus ? .black : .white)
                            .background(viewModel.isMinus ? Color.white : Color.black)
                            .clipShape(Capsule(style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                    }
                    
                }
                .padding(.horizontal, 16)
                
                Text(viewModel.operationAmount == "" ? "Сумма операции" : viewModel.operationAmount + "₽")
                    .foregroundColor(viewModel.operationAmount == "" ? .black.opacity(0.5) : .black)
                    .font(SetupFont.title3())
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.black.opacity(0.1))
                    .clipShape(Capsule(style: .continuous))
                    .padding(16)
                    .onTapGesture {
                        viewModel.isPresentedNumpadView.toggle()
                    }
                
                ShowCategoriesView(viewModel: viewModel)
                    .padding(.horizontal, 16)
                
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
                    
                    Text("Описание заметки (опицонально)")
                        .font(SetupFont.callout())
                        .foregroundColor(viewModel.operationDescription == "" ? .black.opacity(0.1) : .clear)
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
                        .font(SetupFont.callout())
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(viewModel.operationAmount == "" ? Color.black.opacity(0.1) : Color.black)
                        .foregroundColor(viewModel.operationAmount == "" ? Color.black.opacity(0.5) : Color.white)
                        .clipShape(Capsule(style: .continuous))
                        .padding(.horizontal, 16)
                        .shadow(color: .blue.opacity(0.1), radius: 10, x: 0, y: 0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5), value: viewModel.showFullCategories)
                }
                .disabled(viewModel.operationAmount == "" ? true : false)
            }
            .onTapGesture {
                focusedField = nil
            }
            
            // Нампад, который выезжает снизу
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
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct NewOperationView_Previews: PreviewProvider {
    static var previews: some View {
        NewOperationView(viewModel: FinancesViewModel())
    }
}

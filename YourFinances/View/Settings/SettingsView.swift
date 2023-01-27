//
//  SettingsView.swift
//  YourFinances
//
//  Created by Максим Боталов on 27.01.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var selectValute = 0
    @State private var selectLeng = 0
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .top) {
            SetupColor.primary.ignoresSafeArea()
            
            // Заголовок
            VStack {
                Text(Localizable.settings)
                    .font(SetupFont.title3())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                
                List {
                    HStack(alignment: .center, spacing: 8) {
                        Image("Avatar")
                            .resizable()
                            .frame(width: 44, height: 44, alignment: .center)
                            .clipShape(Capsule(style: .continuous))
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Максим Боталов")
                                .font(SetupFont.callout())
                            
                            Text("dev.botalov")
                                .font(SetupFont.footnote())
                        }
                        .foregroundColor(.white)
                    }
                    
                    Picker("Валюта", selection: $selectValute) {
                        Text("Рубль - ₽").tag(0)
                        Text("Доллар - $").tag(1)
                        Text("Евро - €").tag(2)
                        Text("Юань - ¥").tag(3)
                    }
                    
                    Picker("Язык", selection: $selectLeng) {
                        Text("Русский").tag(0)
                        Text("Немецикий").tag(1)
                        Text("Французский").tag(2)
                        Text("Английский").tag(3)
                    }
                    .pickerStyle(.automatic)
                }
                .listRowBackground(SetupColor.secondary)
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                
                Button("Закрыть") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}

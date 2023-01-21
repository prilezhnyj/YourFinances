//
//  StartView.swift
//  YourFinances
//
//  Created by Максим Боталов on 20.01.2023.
//

import SwiftUI

struct StartView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            TextField("Введите вашу почту", text: $email)
            SecureField("Введите ваш пароль", text: $password)
            SecureField("Введите ваш пароль", text: $repeatPassword)
            Button("Войти") {
//                FirebaseAuth().registrationUser(email: email, password: password, repeatPassword: repeatPassword) { _ in }
            }
        }
        .background(Color.white)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
        .padding(16)
        
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

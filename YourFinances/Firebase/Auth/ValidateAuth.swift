//
//  ValidateAuth.swift
//  YourFinances
//
//  Created by Максим Боталов on 20.01.2023.
//

import Foundation

class ValidateAuth {
    static func checkFields(email: String?, password: String?, repeatPassword: String?) -> Bool {
        guard let email = email,
              let password = password,
              let repeatPassword = repeatPassword,
              email != "",
              password != "",
              repeatPassword != "" else { return false }
        return true
    }
    
    static func checkFields(email: String?, password: String?) -> Bool {
        guard let email = email,
              let password = password,
              email != "",
              password != "" else { return false }
        return true
    }
    
    static func checkEmail(email: String?) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
    
    static func checkPassword(_ password: String?) -> Bool {
        let passwordRegEx = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegEx).evaluate(with: password)
    }
}

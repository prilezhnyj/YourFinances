//
//  SetupAuth.swift
//  YourFinances
//
//  Created by Максим Боталов on 20.01.2023.
//

//import Foundation
//import FirebaseAuth
//
//class FirebaseAuth {
//    static let shared = FirebaseAuth()
//    private let auth = Auth.auth()
//    
//    func registrationUser(email: String, password: String, repeatPassword: String, completion: @escaping (Result<User, Error>) -> Void) {
//        guard ValidateAuth.checkFields(email: email, password: password, repeatPassword: repeatPassword) else {
//            completion(.failure(ErrorAuth.notField))
//            return
//        }
//        
//        guard ValidateAuth.checkEmail(email: email) else {
//            completion(.failure(ErrorAuth.invalidEmail))
//            return
//        }
//        
//        guard password == repeatPassword else {
//            completion(.failure(ErrorAuth.passwordNotMatched))
//            return
//        }
//        
//        guard ValidateAuth.checkPassword(password) else {
//            completion(.failure(ErrorAuth.invalidPassword))
//            return
//        }
//        
//        auth.createUser(withEmail: email, password: password) { result, error in
//            guard let user = result?.user else {
//                completion(.failure(error!))
//                return
//            }
//            print(user.email)
//        }
//    }
//}

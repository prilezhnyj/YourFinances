//
//  Localizable.swift
//  YourFinances
//
//  Created by Максим Боталов on 18.01.2023.
//

import SwiftUI

final class Localizable {
    static let noOperations: LocalizedStringKey = "noOperations"
    static let addNew: LocalizedStringKey = "addNew"
    
    static let forMonth: LocalizedStringKey = "inMonth"
    static let month: LocalizedStringKey = FinancesViewModel().getTitleMonth(for: FinancesViewModel().currentDay)
    static let youHaveSaved: LocalizedStringKey = "youHaveSaved"
    static let earned: LocalizedStringKey = "earned"
    static let spent: LocalizedStringKey = "spent"
    
    static let categories: LocalizedStringKey = "categories"
    static let hide: LocalizedStringKey = "hide"
    static let show: LocalizedStringKey = "show"
    
    static let newOperation: LocalizedStringKey = "newOperation"
    static let amount: LocalizedStringKey = "amount"
    static let expense: LocalizedStringKey = "expense"
    static let profit: LocalizedStringKey = "profit"
    static let operationAmount: LocalizedStringKey = "operationAmount"
    static let save: LocalizedStringKey = "save"
    
    static let settings: LocalizedStringKey = "settings"
    
    static let delete: LocalizedStringKey = "delete"
    
    static let expenses: LocalizedStringKey = "expenses"
    static let profits: LocalizedStringKey = "profits"
    
    static let newCategory: LocalizedStringKey = "newCategory"
    static let categoryTitle: LocalizedStringKey = "categoryTitle"
    static let yourCategories: LocalizedStringKey = "yourCategories"
    
    static let info1: LocalizedStringKey = "info1"
    static let info2: LocalizedStringKey = "info2"
    
    static func getKey(for key: String) -> LocalizedStringKey {
        return LocalizedStringKey(key)
    }
}


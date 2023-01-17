//
//  FinancesModel.swift
//  YourFinances
//
//  Created by Максим Боталов on 13.12.2022.
//

import Foundation

struct FinancesModel: Identifiable {
    var id = UUID().uuidString
    var type: FinancesType
    var amount: Double
    var category: CategoryModel
    var date: Date
}

enum FinancesType: String {
    case minus = "Expense"
    case plus = "Profit"
}

struct CategoryModel: Identifiable {
    var id = UUID().uuidString
    var title: String
    var image: String
}

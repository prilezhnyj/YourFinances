//
//  YourFinancesApp.swift
//  YourFinances
//
//  Created by Максим Боталов on 13.12.2022.
//

import SwiftUI

@main
struct YourFinancesApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.colorScheme, .light)
        }
    }
}

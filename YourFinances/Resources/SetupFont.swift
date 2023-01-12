//
//  SetupFont.swift
//  YourFinances
//
//  Created by Максим Боталов on 12.01.2023.
//

import SwiftUI


class SetupFont {
    
    static func title2() -> Font {
        return .system(size: 22, weight: .bold, design: .rounded)
    }
    
    static func title3() -> Font {
        return .system(size: 20, weight: .bold, design: .rounded)
    }
    
    static func callout() -> Font {
        return .system(size: 16, weight: .semibold, design: .rounded)
    }
    
    static func footnote() -> Font {
        return .system(size: 13, weight: .regular, design: .default)
    }
    
    static func footnoteButton() -> Font {
        return .system(size: 13, weight: .bold, design: .rounded)
    }
}

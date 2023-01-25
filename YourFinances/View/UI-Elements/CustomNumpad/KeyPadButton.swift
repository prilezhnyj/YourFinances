//
//  KeyPadButton.swift
//  YourFinances
//
//  Created by Максим Боталов on 08.01.2023.
//

import SwiftUI

struct KeyPadButton: View {
    
    // MARK: - СВОЙСТВА
    var key: String
    
    // MARK: - ТЕЛО
    var body: some View {
        Button(action: { self.action(self.key) }) {
            Color.clear
                .overlay(Capsule(style: .continuous).stroke(SetupColor.white)
                .overlay(Text(key)))
        }
        .font(SetupFont.title3())
        .foregroundColor(SetupColor.white)
        .frame(maxWidth: .infinity)
        .frame(height: 48)
    }
    
    enum ActionKey: EnvironmentKey {
        static var defaultValue: (String) -> Void { { _ in } }
    }
    
    @Environment(\.keyPadButtonAction) var action: (String) -> Void
}

// MARK: - Расширение
extension EnvironmentValues {
    var keyPadButtonAction: (String) -> Void {
        get { self[KeyPadButton.ActionKey.self] }
        set { self[KeyPadButton.ActionKey.self] = newValue }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct KeyPadButton_Previews: PreviewProvider {
    static var previews: some View {
        KeyPadButton(key: "9")
            .previewLayout(.sizeThatFits)
    }
}

//
//  KeyPadButton.swift
//  YourFinances
//
//  Created by Максим Боталов on 08.01.2023.
//

import SwiftUI

struct KeyPadButton: View {
    var key: String
    
    var body: some View {
        Button(action: { self.action(self.key) }) {
            Color.clear
                .overlay(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.1)))
                .overlay(Text(key))
        }
        .font(.system(size: 20, weight: .bold, design: .rounded))
        .foregroundColor(.black)
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
    
    enum ActionKey: EnvironmentKey {
        static var defaultValue: (String) -> Void { { _ in } }
    }
    
    @Environment(\.keyPadButtonAction) var action: (String) -> Void
}

extension EnvironmentValues {
    var keyPadButtonAction: (String) -> Void {
        get { self[KeyPadButton.ActionKey.self] }
        set { self[KeyPadButton.ActionKey.self] = newValue }
    }
}

struct KeyPadButton_Previews: PreviewProvider {
    static var previews: some View {
        KeyPadButton(key: "9")
            .previewLayout(.sizeThatFits)
    }
}

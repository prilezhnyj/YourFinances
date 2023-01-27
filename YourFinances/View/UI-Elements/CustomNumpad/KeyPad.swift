//
//  KeyPad.swift
//  YourFinances
//
//  Created by Максим Боталов on 08.01.2023.
//

import SwiftUI

struct KeyPad: View {
    
    // MARK: - СВОЙСТВА
    @Binding var string: String

    // MARK: - ТЕЛО
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            KeyPadRow(keys: ["1", "2", "3"])
            KeyPadRow(keys: ["4", "5", "6"])
            KeyPadRow(keys: ["7", "8", "9"])
            KeyPadRow(keys: [".", "0", "⌫"])
        }
        .environment(\.keyPadButtonAction, self.keyWasPressed(_:))
    }

    // MARK: - ФУНКЦИИ
    private func keyWasPressed(_ key: String) {
        switch key {
        case "." where string.contains("."): break
        case "." where string == "0": string += key
        case "⌫":
            if string != "" { string.removeLast() }
            if string.isEmpty { string = "" }
        case _ where string == "": string = key
        default: string += key
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct KeyPad_Previews: PreviewProvider {
    static var previews: some View {
        KeyPad(string: .constant("Сумма"))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}

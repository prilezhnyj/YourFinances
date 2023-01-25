//
//  KeyPadRow.swift
//  YourFinances
//
//  Created by Максим Боталов on 08.01.2023.
//

import SwiftUI

struct KeyPadRow: View {
    
    // MARK: - СВОЙСТВА
    var keys: [String]

    // MARK: - ТЕЛО
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            ForEach(keys, id: \.self) { key in
                KeyPadButton(key: key)
            }
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct KeyPadRow_Previews: PreviewProvider {
    static var previews: some View {
        KeyPadRow(keys: ["1", "2", "3"])
            .previewLayout(.sizeThatFits)
    }
}

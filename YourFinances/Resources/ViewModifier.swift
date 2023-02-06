//
//  ViewModifier.swift
//  YourFinances
//
//  Created by Максим Боталов on 27.01.2023.
//

import SwiftUI

struct DescriptionText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(SetupFont.footnote())
            .foregroundColor(.black.opacity(0.5))
            .multilineTextAlignment(.leading)
    }
}

struct AmountField: ViewModifier {
    @EnvironmentObject var viewModel: FinancesViewModel
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(viewModel.operationAmount.isEmpty ? .black.opacity(0.1) : .black)
            .font(SetupFont.title3())
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(.white)
            .clipShape(Capsule(style: .continuous))
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            .onTapGesture {
                DispatchQueue.main.async {
                    withAnimation(.spring()) {
                        viewModel.showNumpadView.toggle()
                    }
                }
            }
    }
}

struct CustomText: ViewModifier {
    var font: Font
    var color: Color
    var alignment: TextAlignment?
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(color)
            .multilineTextAlignment(alignment ?? .leading)
    }
}

struct CustomButton: ViewModifier {
    var font: Font
    var background: Color
    var foreground: Color
    var height: CGFloat
    var maxWidth: CGFloat
    var colorSroke: Color?
    var lineWidth: CGFloat?
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .frame(height: height)
            .frame(maxWidth: maxWidth)
            .background(background)
            .foregroundColor(foreground)
            .clipShape(Capsule(style: .continuous))
            .shadow(color: background.opacity(0.3), radius: 10, x: 0, y: 5)
            .overlay(content: {
                Capsule(style: .continuous)
                    .stroke(lineWidth: lineWidth ?? 1)
                    .foregroundColor(colorSroke ?? .clear)
            })
    }
}

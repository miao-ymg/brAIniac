//
//  ButtonModifier.swift
//  BrAIniac
//
//  Created by Sam Miao on 14.10.24.
//

import SwiftUI

// MARK: View + BackgroundViewModifier
extension View {
    func buttonModifier(backgroundColor: Color) -> some View {
        self
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .foregroundStyle(Color.white)
            .background(backgroundColor)
            .cornerRadius(10)
    }
}

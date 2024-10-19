//
//  ButtonModifier.swift
//  BrAIniac
//
//  Created by Sam Miao on 14.10.24.
//

import SwiftUI

/**
 A view modifier which is used for the style of all buttons throughout the app.

 - Parameter backgroundColor: The `Color` to be used as the background.

 - Returns: The modified button view.

 - Usage:
     ```swift
     Button("Press Me") {
         // Button action
     }
     .buttonModifier(backgroundColor: .blue)
     ```
 */
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

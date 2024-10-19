//
//  FeedbackButtonView.swift
//  BrAIniac
//
//  Created by Sam Miao on 10.10.24.
//

import SwiftUI

/**
 The view representing a button which the user can click on to give feedback to the AI prediction.
 */
struct FeedbackButtonView: View {
    let buttonColor: Color
    /// The icon to be displayed within the button
    let sfsSymbol: String
    let isCorrect: Bool
    @Bindable var viewModel: ViewModel
    
    var body: some View {
        Button {
            viewModel.giveFeedback(isCorrect: isCorrect)
        } label: {
            Image(systemName: sfsSymbol)
        }
        .buttonModifier(backgroundColor: buttonColor)
    }
}

//
//  FeedbackButtonView.swift
//  BrAIniac
//
//  Created by Sam Miao on 10.10.24.
//

import SwiftUI

struct FeedbackButtonView: View {
    let buttonColor: Color
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

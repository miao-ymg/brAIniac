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
            viewModel.clearCanvas()
            viewModel.score.updateScore(isCorrect: isCorrect)
            viewModel.toggleHasRequestedPrediction()
        } label: {
            Image(systemName: sfsSymbol)
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .background(buttonColor)
        .cornerRadius(10)
    }
}

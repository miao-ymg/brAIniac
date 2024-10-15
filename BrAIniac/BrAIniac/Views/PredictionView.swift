//
//  PredictionView.swift
//  BrAIniac
//
//  Created by Sam Miao on 14.10.24.
//

import SwiftUI

struct PredictionView: View {
    @Bindable var viewModel: ViewModel

    var body: some View {
        // Display confidence bar for each digit
        HStack {
            ForEach(viewModel.prediction.confidences, id: \.self) { confidence in
                ConfidenceBarView(
                    conf: confidence,
                    maxConfidence: viewModel.prediction.maxConfidence
                )
            }
        }
        // Display AI prediction
        HStack {
            Text("I recognized: ")
                .font(Font.system(size: 24))
            Text("\(viewModel.prediction.predictedNumber)")
                .font(Font.system(size: 36, weight: .semibold))
        }
        // Allow feedback
        HStack {
            // Correct prediction
            FeedbackButtonView(
                buttonColor: Color.green,
                sfsSymbol: "checkmark",
                isCorrect: true,
                viewModel: viewModel
            )
            .padding(.leading)

            FeedbackButtonView(
                buttonColor: Color.red,
                sfsSymbol: "xmark",
                isCorrect: false,
                viewModel: viewModel
            )
            .padding(.trailing)
        }
        .foregroundStyle(Color.white)
    }
}

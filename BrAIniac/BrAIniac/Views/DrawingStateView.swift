//
//  DrawingStateView.swift
//  BrAIniac
//
//  Created by Sam Miao on 14.10.24.
//

import SwiftUI

struct DrawingStateView: View {
    @Bindable var viewModel: ViewModel

    var body: some View {
        // Instructions
        HStack {
            Image(systemName: "pencil.and.scribble")
            Text("Draw a number between 0 and 9")
                .fontWeight(.medium)
        }
        // Button to clear the canvas
        Button {
            viewModel.clearCanvas()
        } label: {
            Image(systemName: "trash")
            Text("Clear Canvas")
        }
        .buttonModifier(backgroundColor: Color.secondary)
        .padding(.horizontal)

        // Button to make AI prediction
        Button {
            viewModel.makePrediction()
        } label: {
            Image(systemName: "brain.filled.head.profile")
            Text("Recognize Number!")
        }
        .buttonModifier(backgroundColor: Color.blue)
        .padding(.horizontal)
    }
}

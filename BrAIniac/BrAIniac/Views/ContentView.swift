//
//  ContentView.swift
//  BrAIniac
//
//  Created by Sam Miao on 09.10.24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        // Canvas to draw on
        CanvasView(strokes: $viewModel.strokes, appState: viewModel.appState)
            .frame(width: canvasSideLength, height: canvasSideLength)
            // Rounded edges for the canvas
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.secondary, lineWidth: 1)
            )
        
        Spacer()
            .frame(height: 20)
        
        switch viewModel.appState {
        // State A): The drawing has not been created yet
        case .drawing:
            DrawingStateView(viewModel: viewModel)
        // State B): A digit recognition request was made
        case .thinking:
            Text("Thinking...")
                .font(Font.system(size: 36, weight: .semibold))
        // State C): The AI model made a prediction
        case .madePrediction:
            PredictionView(viewModel: viewModel)
        }

        // Scoreboard
        HStack {
            Text("Correct predictions:")
                .font(Font.system(size: 24))
            Text(viewModel.score.displayScore())
                .font(Font.system(size: 36, weight: .semibold))
        }
    }
}

#Preview {
    ContentView()
}

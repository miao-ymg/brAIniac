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
        HStack {
            Text("BrAIniac")
                .font(.custom("Prompt-SemiBold", size: 36))
            Spacer()
        }
        .padding(.leading, 24)
        
        // Canvas to draw on
        VStack {
            CanvasView(
                strokes: $viewModel.strokes,
                canvasSideLength: viewModel.canvasSideLength,
                strokeWidth: viewModel.strokeWidth,
                appState: viewModel.appState
            )
                .frame(width: viewModel.canvasSideLength, height: viewModel.canvasSideLength)
                // Rounded edges for the canvas
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary, lineWidth: 1)
                )
            
            Spacer()
                .frame(height: 24)
            
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
        }
        
        Spacer()

        // Scoreboard
        HStack {
            Text("Correct predictions:")
                .font(Font.system(size: 24))
            Text(viewModel.score.displayScore())
                .font(Font.system(size: 36, weight: .semibold))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.secondary.opacity(0.2))
    }
}

#Preview {
    ContentView()
}

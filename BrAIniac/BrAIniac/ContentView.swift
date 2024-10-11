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
        // Instructions
        HStack {
            Image(systemName: "pencil.and.scribble")
            Text("Draw a number between 0 and 9")
                .fontWeight(.medium)
        }
        
        // Canvas to draw on
        CanvasView(lines: $viewModel.lines)
            .frame(width: dimensions, height: dimensions)
            // Rounded edges for the canvas
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.secondary, lineWidth: 1)
            )
        
        Spacer()
            .frame(height: 20)
        
        // Button to clear the canvas
        Button {
            if !viewModel.hasRequestedPrediction {
                viewModel.clearCanvas()
            }
        } label: {
            Image(systemName: "trash")
            Text("Clear Canvas")
        }
        .frame(height: 50)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .foregroundStyle(Color.white)
        .background(Color.secondary)
        .cornerRadius(10)
        .padding(.horizontal)
        
        // Button to make AI prediction
        Button {
            viewModel.makePrediction()
        } label: {
            Image(systemName: "brain.filled.head.profile")
            Text("Recognize Number!")
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .foregroundStyle(Color.white)
        .background(Color.blue)
        .cornerRadius(10)
        .padding(.horizontal)
        
        if viewModel.hasRequestedPrediction {
            // Display AI prediction
            HStack {
                Text("I recognized: ")
                    .font(Font.system(size: 24))
                Text("\(viewModel.predictedNumber)")
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
        // Scoreboard
        Text("Correct predictions:")
            .font(Font.system(size: 24))
        Text(viewModel.score.displayScore())
            .font(Font.system(size: 36, weight: .semibold))
    }
}

#Preview {
    ContentView()
}

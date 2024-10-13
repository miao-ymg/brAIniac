//
//  ViewModel.swift
//  BrAIniac
//
//  Created by Sam Miao on 10.10.24.
//

import SwiftUI

// GLOBAL CONSTANTS
let sideLength: CGFloat = 280
let strokeWidth: CGFloat = 8

@Observable class ViewModel {
    // The collection of strokes drawn
    var strokes: [[CGPoint]] = []
    // The AI model's prediction
    var prediction = Prediction()
    // An @Observable instance for the scoreboard
    var score = Score()
    // One of three states which the app currently is in
    var appState = AppState.drawing
    
    
    func makePrediction() {
        if strokes.isEmpty {
            return
        }
        
        appState = AppState.thinking
        let drawing = createImage(from: strokes, sideLength: sideLength)
        Task {
            do {
                // Asynchronous call
                let jsonData = try await requestPrediction(image: drawing)
                // Decode API response
                prediction = try JSONDecoder().decode(Prediction.self, from: jsonData)
                appState = AppState.madePrediction
            } catch {
                print("Error during prediction request or decoding: \(error)")
            }
        }
    }
    
    func clearCanvas() {
        strokes.removeAll()
    }
}

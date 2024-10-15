//
//  ViewModel.swift
//  BrAIniac
//
//  Created by Sam Miao on 10.10.24.
//

import SwiftUI
import os

// GLOBAL CONSTANTS
let canvasSideLength: CGFloat = 280
let strokeWidth: CGFloat = 8
// Confidence bar dimensions
let confBarHeight: CGFloat = 100
let confBarWidth: CGFloat = 8

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
        
        Task {
            do {
                let drawing = try createImage(from: strokes, sideLength: canvasSideLength)
                appState = AppState.thinking
                // Asynchronous call
                let jsonData = try await requestPrediction(image: drawing)
                // Decode API response
                prediction = try JSONDecoder().decode(Prediction.self, from: jsonData)
                appState = AppState.madePrediction
            } catch NetworkError.invalidURL {
                Logger().info("ERROR: Invalid URL")
            } catch NetworkError.invalidResponse {
                Logger().info("ERROR: Invalid response")
            } catch NetworkError.invalidData {
                Logger().info("ERROR: Invalid data")
            } catch ImageError.creationFailed {
                Logger().info("ERROR: Failed to create a drawing")
            } catch {
                Logger().info("Unexpected error: \(error)")
            }
        }
    }
    
    func giveFeedback(isCorrect: Bool) {
        clearCanvas()
        score.updateScore(isCorrect: isCorrect)
        appState = AppState.drawing
    }
    
    func clearCanvas() {
        strokes.removeAll()
    }
}

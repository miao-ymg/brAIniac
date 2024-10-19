//
//  ViewModel.swift
//  BrAIniac
//
//  Created by Sam Miao on 10.10.24.
//

import SwiftUI
import os


@Observable class ViewModel {
    /// A 2D array of `CGPoint` values representing the user's drawing.
    var strokes: [[CGPoint]] = []
    var prediction = Prediction()
    var score = Score()
    var appState = AppState.drawing
    /// A boolean indicating whether the user tries to submit an empty drawing.
    var hasEmptySubmission = false
    /// The length of the edges of the canvas
    let canvasSideLength: CGFloat = 280
    /// The width of a stroke when drawing on the canvas
    let strokeWidth: CGFloat = 8
    
    /// Handles the entire process of the user submitting a drawing to request a prediction.
    func makePrediction() {
        // No submission made for an empty canvas
        if strokes.isEmpty {
            hasEmptySubmission = true
            return
        }
        
        Task {
            do {
                let drawing = try createImage(from: strokes, sideLength: canvasSideLength, strokeWidth: strokeWidth)
                appState = AppState.thinking
                hasEmptySubmission = false
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
    
    /**
     Handles the entire process of the user giving feedback to the received prediction.

     - Parameter isCorrect: A boolean value indicating whether the prediction was correct.
     */
    func giveFeedback(isCorrect: Bool) {
        clearCanvas()
        score.updateScore(isCorrect: isCorrect)
        appState = AppState.drawing
    }
    
    /// Clears the canvas
    func clearCanvas() {
        strokes.removeAll()
    }
}

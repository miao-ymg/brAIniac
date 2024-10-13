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
    // A toggle whether a prediction has been requested
    var hasRequestedPrediction: Bool = false
    // The collection of strokes drawn
    var strokes: [[CGPoint]] = []
    // An @Observable instance for the scoreboard
    var score = Score()
    // The AI model's prediction
    var prediction = Prediction()
    
    
    func clearCanvas() {
        strokes.removeAll()
    }
    
    func makePrediction() {
        if !hasRequestedPrediction && !strokes.isEmpty {
            let drawing = createImage(from: strokes, sideLength: sideLength)
            Task {
                do {
                    // Asynchronous call
                    let jsonData = try await requestPrediction(image: drawing)
                    // Decode API response
                    prediction = try JSONDecoder().decode(Prediction.self, from: jsonData)
                } catch {
                    print("Error during prediction request or decoding: \(error)")
                }
            }
            hasRequestedPrediction = true
        }
    }
    
    func toggleHasRequestedPrediction() {
        hasRequestedPrediction.toggle()
    }
}

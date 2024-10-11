//
//  ViewModel.swift
//  BrAIniac
//
//  Created by Sam Miao on 10.10.24.
//

import SwiftUI

@Observable class ViewModel {
    // The AI model's prediction
    var predictedNumber: Int = 0
    // A toggle whether a prediction has been requested
    var hasRequestedPrediction: Bool = false
    // The collection of lines drawn
    var lines: [[CGPoint]] = []
    // An @Observable instance for the scoreboard
    var score = Score()
    
    
    func clearCanvas() {
        lines.removeAll()
    }
    
    func makePrediction() {
        if !hasRequestedPrediction && !lines.isEmpty {
            // MOCK: Only generates a random number so far
            predictedNumber = Int.random(in: 0...9)
            hasRequestedPrediction = true
        }
    }
    
    func toggleHasRequestedPrediction() {
        hasRequestedPrediction.toggle()
    }
}

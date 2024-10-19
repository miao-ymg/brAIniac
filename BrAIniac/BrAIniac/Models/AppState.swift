//
//  AppState.swift
//  BrAIniac
//
//  Created by Sam Miao on 13.10.24.
//

/**
 An enum representing the current state which the app is in.

 - `drawing`: The user is currently drawing on the canvas.
 - `thinking`: The AI is processing the submitted drawing.
 - `madePrediction`: A prediction for the drawing has been made.
 */
enum AppState {
    case drawing
    case thinking
    case madePrediction
}

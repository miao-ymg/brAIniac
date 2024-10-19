//
//  Score.swift
//  BrAIniac
//
//  Created by Sam Miao on 10.10.24.
//

import SwiftUI
import Subsonic

/// A class that tracks the score of correctly recognized digits by the AI.
@Observable class Score {
    /// The respective number of total correct & wrong AI predictions.
    var totalCorrect: Int = 0
    var totalWrong: Int = 0
    /// A sound player which plays a sound depending on the user's feedback.
    let soundPlayer = SubsonicController.shared
    /// The respective number of existing sound files.
    var totalSounds = ["correct": 4, "wrong": 5]
    /// The respective index of the sound file which should be played next.
    var curCorrect = 0
    var curWrong = 0
    
    /**
     Updates the score based on the user's feedback.

     - Parameter isCorrect: A boolean value indicating whether the prediction was correct.
     */
    func updateScore(isCorrect: Bool) {
        if isCorrect {
            curCorrect = (curCorrect + 1) % (totalSounds["correct"] ?? 0)
            soundPlayer.play(sound: "correct-\(curCorrect + 1).mp3")
            totalCorrect += 1
        } else {
            curWrong = (curWrong + 1) % (totalSounds["wrong"] ?? 0)
            soundPlayer.play(sound: "wrong-\(curWrong + 1).mp3")
            totalWrong += 1
        }
    }
    
    /**
     Returns the score to be displayed in the UI.

     - Returns: The string representation of the current score.
     */
    func displayScore() -> String {
        return "\(totalCorrect)/\(totalCorrect + totalWrong)"
    }
}

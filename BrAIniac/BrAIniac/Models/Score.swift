//
//  Score.swift
//  BrAIniac
//
//  Created by Sam Miao on 10.10.24.
//

import SwiftUI
import Subsonic

@Observable class Score {
    var totalCorrect: Int = 0
    var totalWrong: Int = 0
    
    let soundPlayer = SubsonicController.shared
    var totalSounds = ["correct": 4, "wrong": 5]
    // Index of currently selected sounds
    var curCorrect = 0
    var curWrong = 0
    
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
    
    func displayScore() -> String {
        return "\(totalCorrect)/\(totalCorrect + totalWrong)"
    }
}

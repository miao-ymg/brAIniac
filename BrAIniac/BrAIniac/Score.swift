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
    let soundsCorrect = 4
    let soundsWrong = 5
    
    func updateScore(isCorrect: Bool) {
        if isCorrect {
            let num = Int.random(in: 1...soundsCorrect)
            soundPlayer.play(sound: "correct-\(num).mp3")
            totalCorrect += 1
        } else {
            let num = Int.random(in: 1...soundsWrong)
            soundPlayer.play(sound: "wrong-\(num).mp3")
            totalWrong += 1
        }
    }
    
    func displayScore() -> String {
        return "\(totalCorrect)/\(totalCorrect + totalWrong)"
    }
}

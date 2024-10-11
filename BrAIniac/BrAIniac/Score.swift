//
//  Score.swift
//  BrAIniac
//
//  Created by Sam Miao on 10.10.24.
//

import SwiftUI

@Observable class Score {
    var totalCorrect: Int = 0
    var totalWrong: Int = 0
    
    func updateScore(isCorrect: Bool) {
        if isCorrect {
            totalCorrect += 1
        } else {
            totalWrong += 1
        }
    }
    
    func displayScore() -> String {
        return "\(totalCorrect)/\(totalCorrect + totalWrong)"
    }
}

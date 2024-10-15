//
//  Prediction.swift
//  BrAIniac
//
//  Created by Sam Miao on 11.10.24.
//

import SwiftUI

@Observable class Prediction: Decodable {
    var predictedNumber: String = "N/A"
    var maxConfidence: Double = -1
    var confidences: [Confidence] = []
    
    init() { }
    
    enum CodingKeys: String, CodingKey {
        case predictedNumber = "top"
        case maxConfidence = "confidence"
        case confidences = "predictions"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        predictedNumber = try container.decode(String.self, forKey: .predictedNumber)
        maxConfidence = try container.decode(Double.self, forKey: .maxConfidence)
        confidences = try container.decode([Confidence].self, forKey: .confidences)

        // Round confidences to two decimal places
        maxConfidence = myRound(num: maxConfidence)
        confidences = confidences.map {
            Confidence(digit: $0.digit, confidence: myRound(num: $0.confidence))
        }
        // Sort confidences from 0 to 9 using Closures
        confidences = confidences.sorted { $0.digit < $1.digit }
    }
    
    func myRound(num: Double) -> Double {
        return round(num * 1000) / 1000
    }
}

//
//  Prediction.swift
//  BrAIniac
//
//  Created by Sam Miao on 11.10.24.
//

import SwiftUI

/**
 A structure that represents an entire prediction by the AI for a drawing.

 - Conformance:
    - `Decodable`: This struct can be initialized from a JSON object.
 */
@Observable class Prediction: Decodable {
    /// The final predicted number as a string.
    var predictedNumber: String = "N/A"
    /// The confidence for that predicted number.
    var maxConfidence: Double = -1
    /// The confidence properties for each digit between 0-9.
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
    
    /**
     Rounds a given number to three decimal places.

     - Parameter num: The value to be rounded.

     - Returns: The rounded value.
     */
    func myRound(num: Double) -> Double {
        return round(num * 1000) / 1000
    }
}

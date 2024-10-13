//
//  Prediction.swift
//  BrAIniac
//
//  Created by Sam Miao on 11.10.24.
//

import SwiftUI

@Observable class Prediction: Decodable {
    var predictedNumber: String = "N/A"
    var confidences: [Confidence] = []
    
    init() { }
    
    enum CodingKeys: String, CodingKey {
        case predictedNumber = "top"
        case confidences = "predictions"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        predictedNumber = try container.decode(String.self, forKey: .predictedNumber)
        confidences = try container.decode([Confidence].self, forKey: .confidences)

        // Sort confidences from 0 to 9 using Closures
        confidences = confidences.sorted { $0.digit < $1.digit }
    }
}

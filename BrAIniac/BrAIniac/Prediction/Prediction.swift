//
//  Prediction.swift
//  BrAIniac
//
//  Created by Sam Miao on 11.10.24.
//

import SwiftUI

@Observable class Prediction: Decodable {
    var predictedNumber: String = "N/A"
    // var confidences: [Confidence]
    
    init() { }
    
    // Decodable
    enum CodingKeys: String, CodingKey {
        case predictedNumber = "top"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.predictedNumber = try container.decode(String.self, forKey: .predictedNumber)
    }
}

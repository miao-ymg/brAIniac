//
//  Confidence.swift
//  BrAIniac
//
//  Created by Sam Miao on 11.10.24.
//

/**
 A structure that represents the associated confidence level for a given digit.

 - Properties:
    - `digit`: A digit between 0-9 represented as a string.
    - `confidence`: A double value indicating the confidence of the prediction for a given digit, ranging from 0.0 (no confidence) to 1.0 (high confidence).

 - Conformance:
    - `Decodable`: This struct can be initialized from a JSON object.
    - `Hashable`: This struct can be used in collections that require unique elements.
 */
struct Confidence: Decodable, Hashable {
    let digit: String
    let confidence: Double
    
    enum CodingKeys: String, CodingKey {
        case digit = "class"
        case confidence
    }
}

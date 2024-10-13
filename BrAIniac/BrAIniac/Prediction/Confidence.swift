//
//  Confidence.swift
//  BrAIniac
//
//  Created by Sam Miao on 11.10.24.
//

struct Confidence: Decodable, Hashable {
    let digit: String
    let confidence: Double
    
    enum CodingKeys: String, CodingKey {
        case digit = "class"
        case confidence
    }
}

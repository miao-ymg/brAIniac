//
//  Error.swift
//  BrAIniac
//
//  Created by Sam Miao on 12.10.24.
//

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

enum ImageError: Error {
    case creationFailed
}

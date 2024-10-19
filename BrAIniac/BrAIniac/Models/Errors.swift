//
//  Error.swift
//  BrAIniac
//
//  Created by Sam Miao on 12.10.24.
//

/// Network errors which may occur during the API request.
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

/// Image error if the POST data cannot be created from the user's drawing.
enum ImageError: Error {
    case creationFailed
}

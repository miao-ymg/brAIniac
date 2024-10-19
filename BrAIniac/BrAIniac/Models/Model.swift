//
//  Model.swift
//  BrAIniac
//
//  Created by Sam Miao on 11.10.24.
//

import UIKit
import os

/**
 Create an `UIImage` from the user's drawing.

 - Parameters:
   - points: A 2D array of `CGPoint` values representing the user's drawing. Each inner array corresponds to a stroke or path.
   - sideLength: The length of each side of the square image to be created.
   - strokeWidth: The width of a stroke on the generated image.
 
 - Throws: An error if the image creation process fails.
 
 - Returns: A `UIImage` object generated from the points.
 */
func createImage(from points: [[CGPoint]], sideLength: CGFloat, strokeWidth: CGFloat) throws -> UIImage {
    UIGraphicsBeginImageContext(CGSize(width: sideLength, height: sideLength))
    // Black digit required for AI model to work
    UIColor.black.setStroke()
    
    let path = UIBezierPath()
    path.lineWidth = strokeWidth
    
    for pointArray in points {
        guard let firstPoint = pointArray.first else { continue }
        path.move(to: firstPoint)
        
        for point in pointArray.dropFirst() {
            path.addLine(to: point)
        }
    }
    // Create solid lines
    path.stroke()
    
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
        throw ImageError.creationFailed
    }
    UIGraphicsEndImageContext()
    
    return image
}

/**
 Perform an API request to predict the number in the drawing using AI.

 - Parameter image: The `UIImage` to be sent to the server for prediction.
 
 - Throws: An error if the network request fails or the server returns an error.
 
 - Returns: A `Data` object containing the prediction result and confidence values.
 
 - Note: This function uses Swift's `async`/`await` for handling asynchronous requests.
 */
func requestPrediction(image: UIImage) async throws -> Data {
    // Reference: https://universe.roboflow.com/popular-benchmarks/mnist-cjkff/model/1
    
    // Convert image to POST data
    let imageData = image.jpegData(compressionQuality: 1)
    let fileContent = imageData?.base64EncodedString()
    let postData = fileContent?.data(using: .utf8) ?? Data()
    
    // Initialize Inference Server Request
    guard let url = URL(string: "https://classify.roboflow.com/mnist-cjkff/1?api_key=V4yegyaXLxid9UUiR6Dy") else {
        throw NetworkError.invalidURL
    }
    var request = URLRequest(url: url, timeoutInterval: Double.infinity)
    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = postData
    
    let logger = Logger()
    // Execute Post Request
    logger.info("Making prediction request...")
    
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        // Ensure the response is valid
        guard let httpResponse = response as? HTTPURLResponse, [200, 301, 302].contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }

        if let jsonString = String(data: data, encoding: .utf8) {
            logger.info("\(jsonString)")
        }
        return data
    } catch {
        throw NetworkError.invalidData
    }
}

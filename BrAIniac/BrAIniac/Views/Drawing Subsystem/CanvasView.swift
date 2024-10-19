//
//  CanvasView.swift
//  BrAIniac
//
//  Created by Sam Miao on 09.10.24.
//

import SwiftUI

/**
 A view that represents the canvas where users can draw a digit on.
 */
struct CanvasView: View {
    @Binding var strokes: [[CGPoint]]
    let canvasSideLength: CGFloat
    let strokeWidth: CGFloat
    var appState: AppState
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Canvas background
                Color.white
                
                Path { path in
                    for stroke in strokes {
                        path.addLines(stroke)
                    }
                }
                .stroke(Color.blue, lineWidth: strokeWidth)
            }
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in
                    if appState != AppState.drawing {
                        return
                    }

                    let location = value.location
                    // Normalized location of drawn point
                    let localLocation = CGPoint(
                        x: location.x - geometry.frame(in: .local).minX,
                        y: location.y - geometry.frame(in: .local).minY
                    )
                    // Check if user's finger is within canvas frame
                    if isWithinEdges(coordinate: localLocation.x) && isWithinEdges(coordinate: localLocation.y) {
                        if strokes.isEmpty || (strokes.last?.isEmpty ?? true) {
                            strokes.append([localLocation])
                        } else {
                            strokes[strokes.count - 1].append(localLocation)
                        }
                    }
                }
                .onEnded { _ in
                    if appState == AppState.drawing {
                        // Prepare new stroke
                        strokes.append([])
                    }
                }
            )
        }
    }
    
    /**
     Checks if the user's finger is within the defined edges of the canvas.

     - Parameter coordinate: A `Double` value representing a coordinate to check.

     - Returns: A boolean value indicating whether the finger is within (`true`) or outside (`false`) the edges.
     */
    func isWithinEdges(coordinate: Double) -> Bool {
        return (strokeWidth / 2...canvasSideLength - strokeWidth / 2).contains(coordinate)
    }
}

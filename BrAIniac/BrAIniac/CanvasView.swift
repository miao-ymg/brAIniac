//
//  CanvasView.swift
//  BrAIniac
//
//  Created by Sam Miao on 09.10.24.
//

import SwiftUI

struct CanvasView: View {
    @Binding var strokes: [[CGPoint]]
    
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
                    // Prepare new stroke
                    strokes.append([])
                }
            )
        }
    }
}


func isWithinEdges(coordinate: Double) -> Bool {
    return (strokeWidth / 2...sideLength - strokeWidth / 2).contains(coordinate)
}

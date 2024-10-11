//
//  CanvasView.swift
//  BrAIniac
//
//  Created by Sam Miao on 09.10.24.
//

import SwiftUI

let dimensions: CGFloat = 280
let lineWidth: CGFloat = 10

struct CanvasView: View {
    @Binding var lines: [[CGPoint]]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                
                Path { path in
                    for line in lines {
                        path.addLines(line)
                    }
                }
                .stroke(Color.blue, lineWidth: lineWidth)
            }
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in
                    let location = value.location
                    let localLocation = CGPoint(
                        x: location.x - geometry.frame(in: .local).minX,
                        y: location.y - geometry.frame(in: .local).minY
                    )
                    
                    if isWithinEdges(coordinate: localLocation.x) && isWithinEdges(coordinate: localLocation.y) {
                        if lines.isEmpty || (lines.last?.isEmpty ?? true) {
                            lines.append([localLocation])
                        } else {
                            lines[lines.count - 1].append(localLocation)
                        }
                    }
                }
                .onEnded { _ in
                    lines.append([])
                }
            )
        }
    }
}


func isWithinEdges(coordinate: Double) -> Bool {
    return (lineWidth / 2...dimensions - lineWidth / 2).contains(coordinate)
}

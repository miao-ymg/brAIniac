//
//  ConfidenceBarView.swift
//  BrAIniac
//
//  Created by Sam Miao on 13.10.24.
//

import SwiftUI

/**
 A view to display an individual confidence bar for a digit.
 */
struct ConfidenceBarView: View {
    /// The height & width of the confidence bar views.
    let confBarHeight: CGFloat = 120
    let confBarWidth: CGFloat = 12
    
    let conf: Confidence
    /// The maximum existing confidence level of the parent prediction.
    let maxConfidence: Double
    /// The dynamic height of the displayed confidence capsule view for animation.
    @State private var animatedHeight: CGFloat = 0

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule()
                    .fill(Color.light)
                    .frame(height: confBarHeight)
                Capsule()
                    .fill(conf.confidence == maxConfidence ? Color.teal : Color.gray)
                    .frame(height: animatedHeight)
                    .animation(.easeInOut(duration: 0.5), value: animatedHeight)
            }
            .frame(width: confBarWidth)
            
            Text("\(conf.digit)")
                .font(Font.system(size: 28, weight: .medium))
        }
        .onAppear {
            withAnimation {
                animatedHeight = computeConfidenceHeight(confidence: conf.confidence)
            }
        }
    }
    
    /**
     Computes the theoretical height of a confidence capsule view based on a confidence level.

     - Parameter confidence: A `Double` representing a confidence level.

     - Returns: A `CGFloat` representing the computed theoretical view height.
     */
    func computeConfidenceHeight(confidence: Double) -> CGFloat {
        if confidence == 0 {
            return 0
        }
        return confBarWidth + confidence * (confBarHeight - 2 * confBarWidth)
    }
}

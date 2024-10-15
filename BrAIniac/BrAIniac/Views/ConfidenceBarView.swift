//
//  ConfidenceBarView.swift
//  BrAIniac
//
//  Created by Sam Miao on 13.10.24.
//

import SwiftUI

struct ConfidenceBarView: View {
    let conf: Confidence
    let maxConfidence: Double
    @State private var animatedHeight: CGFloat = 0

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule()
                    .fill(Color.white)
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
    
    func computeConfidenceHeight(confidence: Double) -> CGFloat {
        if confidence == 0 {
            return 0
        }
        return confBarWidth + confidence * (confBarHeight - 2 * confBarWidth)
    }
}

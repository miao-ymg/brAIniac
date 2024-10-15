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

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule()
                    .fill(Color.white)
                    .frame(height: confBarHeight)
                Capsule()
                    .fill(conf.confidence == maxConfidence ? Color.teal : Color.gray)
                    .frame(height: computeConfidenceHeight(confidence: conf.confidence))
            }
            .frame(width: confBarWidth)

            Text("\(conf.digit)")
        }
    }

    func computeConfidenceHeight(confidence: Double) -> CGFloat {
        if confidence == 0 {
            return 0
        }
        return confBarWidth + confidence * (confBarHeight - 2 * confBarWidth)
    }
}

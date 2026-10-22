//
//  ShapeLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/21/26.
//

import SwiftUI

struct ShapeLabView: View {
    @State private var isContinuous = true
    @State private var progressStep = 0
    @State private var progress = 0.0

    var body: some View {
        ScrollView {
            Text("Shape Lab")
                .font(.title).fontDesign(.serif).fontWeight(.black)
            
            HStack {
                Path { path in
                    path.move(to: CGPoint(x: 110, y: 10))
                    path.addLine(to: CGPoint(x: 210, y: 130))
                    path.addLine(to: CGPoint(x: 10, y: 130))
                    path.closeSubpath()
                }
                .stroke(.orange, lineWidth: 6)
                .frame(width: 220, height: 140)
                Path { path in
                    path.move(to: CGPoint(x: 10, y: 130))
                    path.addQuadCurve(
                        to: CGPoint(x: 230, y: 130),
                        control: CGPoint(x: 120, y: -40)
                    )
                }
                .stroke(
                    .blue,
                    style: StrokeStyle(
                        lineWidth: 6,
                        lineCap: .round
                    )
                )
                .frame(width: 240, height: 150)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(.blue, style: StrokeStyle(lineWidth: 12))
                    .frame(width: 100, height: 100)
                Button {
                    if progressStep == 10 {
                        progressStep = 0
                    } else {
                        progressStep = progressStep + 1
                    }
                    progress = Double(progressStep) * 0.1
                } label: {
                    Text(progress, format: .percent)
                        .monospacedDigit()
                        .frame(width: 70, height: 24)
                }
            }
            
            HStack {
                Circle()
                Circle().fill(.blue).strokeBorder(.black, lineWidth: 4)  // 안으로만
                Circle().stroke(.blue, lineWidth: 4)  // 이건 안밖 각각 2 point씩
                Circle().fill(.black).strokeBorder(
                    .blue,
                    style: StrokeStyle(
                        lineWidth: 4,
                        lineCap: .round,
                        lineJoin: .round,
                        dash: [20, 10, 50, 10]
                    )
                )
            }
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.blue.opacity(0.15))
                .overlay {
                    RoundedRectangle(cornerRadius: 64)
                        .strokeBorder(.blue, lineWidth: 3)
                }
                .frame(height: 100)
            
            HStack {
                RoundedRectangle(
                    cornerRadius: 64,
                    style: isContinuous ? .continuous : .circular
                )
                .frame(height: 100)
                VStack {
                    Button("style 바꾸기") {
                        isContinuous.toggle()
                    }
                    Text(isContinuous ? ".continuous" : ".circular")
                }
            }
            
            HStack {
                Rectangle()
                RoundedRectangle(cornerRadius: 32)
                Circle()
                Ellipse().frame(width: 150, height: 100)
                Capsule().frame(width: 150, height: 100)
            }
        }
        .padding()
    }
}

#Preview {
    ShapeLabView()
}

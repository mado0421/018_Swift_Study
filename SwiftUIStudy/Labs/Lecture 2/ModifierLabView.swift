//
//  ModifierLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/22/26.
//

import SwiftUI

struct ModifierLabView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("위쪽 콘텐츠")
                .font(.title)

            Text("파란 배경이 어디까지 그려지는지 확인")

            Spacer()

            Text("아래쪽 콘텐츠")
        }
        .padding(20)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .background(
            .blue.opacity(0.25),
            ignoresSafeAreaEdges: .all
        )
//        ScrollView {
//            VStack(alignment: .leading, spacing: 28) {
//                Text("Modifier Lab")
//                    .font(.largeTitle)
//
//                paddingComparison
//
//                frameComparison
//
//                overlayExample
//
//                borderComparison
//            }
//            .padding(24)
//            .frame(maxWidth: .infinity, alignment: .leading)
//        }
    }

    private var paddingComparison: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("1. padding과 background")
                .font(.headline)

            Text("padding → background")
                .padding(20)
                .background(.blue.opacity(0.2))
                .border(.blue)

            Text("background → padding")
                .background(.blue.opacity(0.2))
                .padding(20)
                .border(.blue)
        }
    }

    private var frameComparison: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("2. frame과 background")
                .font(.headline)

            Text("frame → background")
                .frame(
                    width: 280,
                    height: 90,
                    alignment: .center
                )
                .background(.green.opacity(0.2))
                .border(.green)

            Text("background → frame")
                .background(.green.opacity(0.2))
                .frame(
                    width: 280,
                    height: 90,
                    alignment: .center
                )
                .border(.green)
        }
    }

    private var overlayExample: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("3. overlay 정렬")
                .font(.headline)

            Text("주 콘텐츠")
                .frame(width: 280, height: 120)
                .background(
                    .blue.opacity(0.15),
                    in: RoundedRectangle(cornerRadius: 16)
                )
                .overlay(alignment: .topTrailing) {
                    Text("NEW")
                        .font(.caption.bold())
                        .padding(6)
                        .background(.orange, in: Capsule())
                        .padding(8)
                }
        }
    }

    private var borderComparison: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("4. 사각 테두리와 둥근 테두리")
                .font(.headline)

            Text("border")
                .frame(width: 280, height: 80)
                .background(
                    .purple.opacity(0.15),
                    in: RoundedRectangle(cornerRadius: 20)
                )
                .border(.purple, width: 4)

            Text("overlay + strokeBorder")
                .frame(width: 280, height: 80)
                .background(
                    .purple.opacity(0.15),
                    in: RoundedRectangle(cornerRadius: 20)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(.purple, lineWidth: 4)
                }
        }
    }
}

#Preview {
    ModifierLabView()
}

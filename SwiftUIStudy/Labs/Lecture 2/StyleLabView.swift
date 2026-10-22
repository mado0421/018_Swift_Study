//
//  StyleLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/22/26.
//

import SwiftUI

struct StyleLabView: View {
    var body: some View {
        //        ScrollView {
        VStack(alignment: .leading, spacing: 32) {
            HStack {
                Text("Style Lab")
                    .font(
                        .system(
                            size: 64,
                            weight: .semibold,
                            design: .rounded
                        )
                    )
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white, .green, .brown],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .shadow(radius: 1, x: 1, y: 2)
                ZStack {
                    LinearGradient(
                        colors: [.red, .orange, .yellow, .white],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .blur(radius: 4)
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            RadialGradient(
                                colors: [.white, .yellow, .orange],
                                center: .center,
                                startRadius: 0,
                                endRadius: 100
                            )
                        )
                        .shadow(radius: 1, x: 1, y: 3)
                        .padding()
                    HStack {
                        Text("글래스 텍스트")
                            .padding(8)
                            .glassEffect(.clear)
                        Text("텍스트")
                            .font(.system(size: 30, weight: .black))
                            .foregroundStyle(.white)
                            .blur(radius: 1)
                        Button("글래스 버튼") {

                        }
                        .buttonStyle(.glass)
                    }
                }
            }.frame(height: 80)
            GlassEffectContainer(spacing: 30) {
                HStack {
                    Image(systemName: "pencil")
                        .font(.system(size: 30, weight: .black))
                        .foregroundStyle(.labAccent)
                        .padding()
                        .glassEffect(in: Circle())
                    Image(systemName: "eraser")
                        .font(.system(size: 30, weight: .black))
                        .foregroundStyle(.labAccent)
                        .padding()
                        .glassEffect(in: RoundedRectangle(cornerRadius: 16))
                }
                .frame(maxWidth: .infinity)
                .border(.blue, width: 5)
            }.frame(height: 80)
            HStack {
                VStack {
                    Text("주요 정보")
                        .foregroundStyle(.primary)

                    Text("보조 정보")
                        .foregroundStyle(.secondary)

                    Text("추가 정보")
                        .foregroundStyle(.tertiary)

                    Text("낮은 강조")
                        .foregroundStyle(.quaternary)
                }
                .foregroundStyle(.brown)
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [.blue, .orange],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        Gradient(stops: [
                            .init(color: .green, location: 0),
                            .init(color: .brown, location: 0.3),
                            .init(color: .indigo, location: 1),
                        ])
                    )
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [.red, .yellow, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        RadialGradient(
                            colors: [.yellow, .purple, .black],
                            center: .top,
                            startRadius: 0,
                            endRadius: 120
                        )
                    )
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        AngularGradient(
                            colors: [.red, .orange, .yellow],
                            center: .center,
                            angle: .degrees(0)
                        )
                    )
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        AngularGradient(
                            colors: [.red, .orange, .yellow],
                            center: .center,
                            startAngle: .degrees(0),
                            endAngle: .degrees(90)
                        )
                    )
            }.frame(height: 80)
            HStack {
                Circle()
                    .fill(.indigo)
                Circle()
                    .fill(.teal)
                Circle()
                    .fill(.tertiary)
                Circle()
                    .fill(.mint)
                Circle()
                    .fill(.quaternary)
                Circle()
                    .fill(.brown)
                Rectangle()
                    .fill(
                        Color(
                            .displayP3,
                            red: 0.2,
                            green: 0.3,
                            blue: 0.8,
                            opacity: 0.5
                        )
                    )
                Rectangle()
                    .fill(
                        Color(
                            hue: 0.2,
                            saturation: 0.3,
                            brightness: 0.8,
                            opacity: 0.5
                        )
                    )
                Rectangle()
                    .fill(Color(white: 0.5, opacity: 0.5))
            }.frame(height: 80)
            HStack {
                Text("주요 정보")
                    .foregroundStyle(.primary)
                Text("보조 정보")
                    .foregroundStyle(.secondary)
                Text("텍스트")
                    .padding()
                    .background(
                        .blue.opacity(0.2),
                        in: RoundedRectangle(cornerRadius: 16)
                    )
                Text("텍스트")
                    .padding()
                    .background(
                        .blue,
                        in: RoundedRectangle(cornerRadius: 16)
                    )
                    .opacity(0.2)
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(
                        AngularGradient(
                            colors: [.blue, .clear, .cyan, .clear, .blue],
                            center: .center,
                            angle: .degrees(0)
                        ),
                        lineWidth: 10
                    )
            }.frame(height: 80)
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        //        }
    }
}

#Preview("밝은 화면") {
    StyleLabView()
        .preferredColorScheme(.light)
}

#Preview("어두운 화면") {
    StyleLabView()
        .preferredColorScheme(.dark)
}

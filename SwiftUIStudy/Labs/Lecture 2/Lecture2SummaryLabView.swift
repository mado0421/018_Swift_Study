//
//  Lecture2SummaryLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/22/26.
//

import SwiftUI

struct Lecture2SummaryLabView: View {
    @State private var isBlurred = false
    @State private var isGrayscale = false
    @State private var isFaded = false
    @State private var hasShadow = true
    @State private var isRounded = true

    @State private var progressStep = 3
    private var progress: Double {
        Double(progressStep) / 10.0
    }

    private var accentGradient: some ShapeStyle {
        LinearGradient(
            colors: [.blue, .purple, .pink],
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Text("Lecture 2 Summary Lab")
                        .font(.largeTitle.bold())
                        .foregroundStyle(accentGradient)

                    Button("초기화") {
                        progressStep = 3
                        isRounded = true
                        hasShadow = true
                        isFaded = false
                        isBlurred = false
                        isGrayscale = false
                    }
                }

                summaryCard

                controls

                modifierOrderComparison
            }
            .padding(32)
            .frame(maxWidth: .infinity)
        }
    }

    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image("LabPhoto")
                .resizable()
                .scaledToFill()
                .frame(width: 312, height: 180)
                .blur(radius: isBlurred ? 8 : 0)
                .grayscale(isGrayscale ? 1 : 0)
                .mask {
                    LinearGradient(
                        stops: [
                            .init(color: .white, location: 0),
                            .init(color: .white, location: 0.55),
                            .init(
                                color: isFaded ? .clear : .black,
                                location: 1
                            ),
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                }
                .clipShape(
                    RoundedRectangle(cornerRadius: isRounded ? 16 : 0)
                )
                .overlay(alignment: .topTrailing) {
                    Label {
                        Text("Lecture 2")
                    } icon: {
                        Image(systemName: "paintbrush.fill")
                    }
                    .font(.caption.bold())
                    .labelStyle(.titleAndIcon)
                    .padding(8)
                    // .regularMaterial은 뒤쪽을 흐리게 반영하면서 앞을 읽기 쉽게 만드는 시스템 배경 재질
                    .background(.regularMaterial, in: Capsule())
                    .padding(12)
                }

            Text("something\n2 lines")
                .font(.body)
                .foregroundStyle(.secondary)

            progressDisplay

            curve
        }
        .padding(24)  // 내부에 패딩을 각각 넣지 말고 여기 넣어서 한 번에 하자.
        .frame(width: 360)
        .background {
            RoundedRectangle(cornerRadius: isRounded ? 24 : 0)
                .fill(.background)
                .strokeBorder(accentGradient, lineWidth: 2)
        }
        .shadow(
            color: .black.opacity(hasShadow ? 0.25 : 0),
            radius: 12,
            y: 8
        )

    }

    // 커브 하는 법 잊어버림... path in을 써서 한다...
    private var curve: some View {
        Path { path in
            path.move(to: .init(x: 0, y: 30))
            path.addQuadCurve(
                to: .init(x: 312, y: 30),
                control: .init(x: 156, y: -20)
            )
        }
        .stroke(
            accentGradient,
            style: StrokeStyle(
                lineWidth: 3,
                lineCap: .round
            )
        )
        .frame(width: 312, height: 40)
    }

    private var progressDisplay: some View {
        HStack {
            ZStack {
                Circle()
                    .stroke(.gray.opacity(0.2), lineWidth: 8)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        accentGradient,
                        style: StrokeStyle(
                            lineWidth: 8,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                Text(progress, format: .percent)
                    .font(.headline)
                    .monospacedDigit()
            }.frame(width: 80, height: 80)
            /*
             이건 아래와 같이 줄일 수 있다.
             progressStep = (progressStep + 1) % 11
             */
            Button("10% 증가") {
                if progressStep == 10 {
                    progressStep = 0
                } else {
                    progressStep += 1
                }
            }
        }
    }

    private var controls: some View {
        VStack {
            HStack {
                Button("페이드 토글") { isFaded.toggle() }
                Button("블러 토글") { isBlurred.toggle() }
                Button("그레이스케일 토글") { isGrayscale.toggle() }
            }
            HStack {
                Button("테두리 둥글마감 토글") { isRounded.toggle() }
                Button("그림자 토글") { hasShadow.toggle() }
            }
        }
    }

    private var modifierOrderComparison: some View {
        /*
         ViewThatFits는 주어진 공간에 맞는 View를 선택하는 컨테이너.
         */
        ViewThatFits(in: .horizontal) {
            HStack(alignment: .top, spacing: 32) {
                paddingOrderComparison
                    .fixedSize(horizontal: true, vertical: false)
                shadowOrderComparison
                    .frame(width: 360)
            }
            VStack(alignment: .leading, spacing: 32) {
                paddingOrderComparison
                shadowOrderComparison
            }
        }
        
        

    }
    
    private var paddingOrderComparison: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Padding and Background")
                .font(.headline)
            VStack {
                Text("padding -> background")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                Text("SwiftUI")
                    .padding(20)
                    .background(.mint)
                    .border(.black, width: 2)
            }
            VStack {
                Text("background -> padding")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                Text("SwiftUI")
                    .background(.mint)
                    .padding(20)
                    .border(.black, width: 2)
            }
        }.fixedSize(horizontal: false, vertical: true)
    }

    private var shadowOrderComparison: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Clipping and Shadow")
                .font(.headline)
            Text("clipShape -> shadow")
                .padding(12)
                .frame(maxWidth: .infinity, minHeight: 80)
                .background(.orange)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black.opacity(0.35), radius: 10, y: 8)
            Text("shadow -> clipShape")
                .padding(12)
                .frame(maxWidth: .infinity, minHeight: 80)
                .background(.orange)
                .shadow(color: .black.opacity(0.35), radius: 10, y: 8)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .frame(maxWidth: 360)
    }
}

#Preview {
    Lecture2SummaryLabView()
}

#Preview {
    Lecture2SummaryLabView()
        .preferredColorScheme(.dark)
}

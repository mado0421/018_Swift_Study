//
//  Lecture3SummaryLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/26/26.
//

import SwiftUI

struct Lecture3Data: Identifiable {
    let id: Int
    let title: String
    let description: String
    let tag: String
}

struct Lecture3SummaryLabView: View {
    @State private var isWide = true
    @State private var hasBorder = true
    private static let sampleData: [Lecture3Data] = getDataList()
    @State private var items: [Lecture3Data] = Self.sampleData

    private var myGradient: some ShapeStyle {
        LinearGradient(
            colors: [.yellow, .orange, .pink],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var body: some View {
        VStack(spacing: 16) {
            controlPanel
            contents
        }
    }

    private var currentWidth: CGFloat { isWide ? 560 : 320 }
    private var controlPanel: some View {
        VStack {
            Text("Lecture 3 자료 보관함")
                .font(.system(.title, design: .rounded, weight: .black))
                .foregroundStyle(myGradient)
            HStack {
                Button("좁게") {
                    isWide = false
                }
                Button("넓게") {
                    isWide = true
                }
                Button("경계 표시 / 숨기기") {
                    hasBorder.toggle()
                }
                Button("초기화") {
                    isWide = true
                    hasBorder = true
                }
            }
            Text(
                "current width: \(Int(currentWidth))pt, hasBorder: \(String(hasBorder))"
            )
        }
        .padding()
        .border(myGradient, width: hasBorder ? 2 : 0)
    }

    private var contents: some View {
        ScrollView {
            VStack(spacing: 24) {
                header
                containerInformation
                dataList
                compareSize
            }
        }
        .frame(width: currentWidth)
        .padding()
    }

    private var header: some View {
        ViewThatFits(in: .horizontal) {
            HStack(spacing: 16) {
                introduceContainer
                introduceProcess
            }
            VStack(spacing: 16) {
                introduceContainer
                introduceProcess
            }
        }
        .border(myGradient, width: hasBorder ? 2 : 0)
    }
    private var introduceContainer: some View {
        VStack(alignment: .leading) {
            Text("길이 테스트용 긴 문장")
                .font(.title2)
            Text(
                "リライト    3:45    2026. 10. 28. 오후 2:20    ASIAN KUNG-FU GENERATION    ソルファ    Rock    0    4    2004"
            )
            .font(.caption)
        }
        .padding()
        .frame(width: 240)
    }
    private var introduceProcess: some View {
        VStack {
            Text("Shin Takara Jima    5:06    2025. 6. 17. 오후 4:43    sakanaction    Shin Takara Jima - EP    Rock    2    6    2015")
                .font(.footnote)
        }
        .padding()
        .frame(width: 240)
    }

    private var containerInformation: some View {
        Grid(alignment: .leading, horizontalSpacing: 12, verticalSpacing: 0) {
            GridRow {
                Text("보관함")
                    .font(.title3)
                Text("SwiftUI 학습 자료")
            }
            GridRow {
                Text("전체 자료 수")
                    .font(.title3)
                Text("\(items.count)개")
            }
            GridRow {
                Text("표시 방식")
                    .font(.title3)
                Text("너비에 따른 격자 배치")
            }
        }
        .padding()
        .border(myGradient, width: hasBorder ? 2 : 0)
    }

    // data 배열 하나 만들어서 초기화 하는거 해둬야 할 듯 -> static data와 @State 데이터 만들어서 준비 완료
    private static func getDataList() -> [Lecture3Data] {
        let titles: [String] = [
            "Shin Takara Jima",
            "Bubble",
            "Inferno",
            "Bokuno Koto",
            "Obenkyou Shitoiteyo",
            "リライト",
            "Kaiju",
            "Heroine",
            "Sparkle",
        ]
        let descriptions: [String] = [
            "2027 공연 셋리스트 중 한 곡입니다.",
            "유명한 JPOP 곡입니다.",
            "어렵지만 재밌는 곡입니다.",
            "연주하는데 성공한다면 뿌듯할 곡입니다.",
        ]
        let tags: [String] = [
            "JPOP"
        ]
        var dataArray: [Lecture3Data] = []
        for index in 0...23 {
            dataArray.append(
                Lecture3Data(
                    id: index,
                    title: titles.randomElement() ?? "신보물섬",
                    description: descriptions.randomElement()
                        ?? "유명한 JPOP 곡입니다.",
                    tag: tags.randomElement() ?? "JPOP"
                )
            )
        }

        return dataArray
    }
    private var dataList: some View {
        // 사이 간격을 12로 하긴 했는데 열 사이? 행 사이? 인지는 모름.
        // -> GridItem의 spacing은 열 간격, LazyVGrid의 spacing은 행 간격.
        // 카드의 위쪽을 통일하려는 경우 GridItem에 alignment: .top 같이 추가
        let columns = [
            GridItem(.adaptive(minimum: 120), spacing: 12, alignment: .top)
        ]

        return LazyVGrid(columns: columns, spacing: 12) {
            ForEach(items, id: \.id) { data in
                VStack(alignment: .leading) {
                    // 미리 두 줄을 할당해 놓고 싶은데 그건 어떻게 할까? -> reservesSpace: true

                    Text(data.title)
                        .font(
                            .system(.title, design: .rounded, weight: .semibold)
                        )
                        .lineLimit(2, reservesSpace: true)
                        .truncationMode(.tail)
                    Text(data.description)
                        .font(.caption)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 12)
                    Text(data.tag)
                        .font(
                            .system(
                                .caption,
                                design: .rounded,
                                weight: .semibold
                            )
                        )
                        .foregroundStyle(.white)
                        .padding(6)
                        .fixedSize()
                        .background(Capsule().fill(myGradient))
                }
                // 안의 내용들의 가로 시작선을 통일하고 싶은데 그건 어떻게 할까?
                // -> frame에 alignment .leading 처리
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(myGradient.opacity(0.2))
                        // 왜 hasBorder를 바꾸는데 내용이 막 바뀌지?
                        // -> 기존 샘플 데이터를 body에서 만들고 있었기 때문
                        .strokeBorder(myGradient, lineWidth: hasBorder ? 3 : 0)
                }
            }
        }
    }

    private var defaultRectangle: some View {
        Rectangle()
            .fill(myGradient)
            .frame(width: 80, height: 40)
            .border(.green, width: hasBorder ? 2 : 0)
    }
    private var compareSize: some View {
        VStack {
            Text("녹색은 원본, 붉은색은 패딩 추가, 파란색은 프레임")
                .font(.caption)
            defaultRectangle
                .overlay(alignment: .topLeading) {
                    Text("원본").font(.caption)
                }
            defaultRectangle
                .padding(12)
                .border(.red, width: hasBorder ? 2 : 0)
                .frame(width: 160, height: 100)
                .border(.blue, width: hasBorder ? 2 : 0)
                .overlay(alignment: .topLeading) {
                    Text("고정 너비").font(.caption)
                }
            defaultRectangle
                .padding(12)
                .border(.red, width: hasBorder ? 2 : 0)
                .frame(height: 100)
                .border(.blue, width: hasBorder ? 2 : 0)
                .overlay(alignment: .topLeading) {
                    Text("콘텐츠 너비 따르기").font(.caption)
                }

        }
    }

}

#Preview {
    Lecture3SummaryLabView()
}

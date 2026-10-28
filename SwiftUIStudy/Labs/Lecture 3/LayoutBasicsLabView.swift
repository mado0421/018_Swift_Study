//
//  LayoutBasicsLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/22/26.
//

import SwiftUI

struct LayoutBasicsLabView: View {
    var body: some View {
        ScrollView {
            
            // 너비 180의 제안에 맞춰 Text가 줄바꿈하는 모습을 관찰한다.
            Text("SwiftUI 레이아웃은 부모의 제안과 자식의 크기 응답으로 결정.")
                .font(.system(size: 20))
                .fixedSize(horizontal: false, vertical: true)
                .border(.red, width: 2)
                .frame(width: 180, alignment: .topLeading)
                .border(.blue, width: 2)
                .padding(24)
            
            // fixedSize가 이상적인 크기를 요청하면 안쪽 프레임이 120 × 40을 제안한다.
            Rectangle()
                .fill(.orange.opacity(0.4))
                .frame(idealWidth: 120, idealHeight: 40)
                .fixedSize()
                .border(.red, width: 2)
                .frame(width: 240, height: 80)
                .border(.blue, width: 2)
                .padding(24)
            
            // 고정 크기 80 × 40에 사방 20pt의 패딩을 더해 120 × 80을 보고한다.
            Rectangle()
                .fill(.orange.opacity(0.4))
                .frame(width: 80, height: 40)
                .border(.red, width: 2)
                .padding(20)
                .border(.green, width: 2)
                .frame(width: 240, height: 120)
                .border(.blue, width: 2)

            // 두 고정 크기 사각형 사이에서 Spacer가 남은 가로 공간을 사용한다.
            HStack(spacing: 0) {
                Rectangle()
                    .fill(.orange.opacity(0.5))
                    .frame(width: 80, height: 40)

                Spacer(minLength: 0)

                Rectangle()
                    .fill(.green.opacity(0.5))
                    .frame(width: 60, height: 40)
            }
            .border(.purple, width: 2)
            .frame(width: 200, height: 80)
            .border(.blue, width: 2)
            .padding(24)
            .overlay(alignment: .topLeading) {
                Text("Spacer()")
                    .font(.caption)
            }

            VStack {
                Text("SwiftUI")
                    .font(.system(size: 24))
                    .border(.red, width: 2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.green.opacity(0.2))
                    .border(.green, width: 2)
                    .frame(width: 320, height: 80)
                    .border(.blue, width: 2)

                Text("SwiftUI")
                    .font(.system(size: 24))
                    .border(.red, width: 2)
                    .frame(minWidth: 120, maxWidth: 240, alignment: .leading)
                    .background(.green.opacity(0.2))
                    .border(.green, width: 2)
                    .frame(height: 80)
                    .border(.blue, width: 2)
            }
            .padding()
            .overlay(alignment: .topLeading) {
                Text("frame settings")
                    .font(.caption)
            }

            VStack(alignment: .leading, spacing: 24) {
                Text("SwiftUI")
                    .font(.system(size: 24))
                    .border(.red, width: 2)
                    .frame(width: 240, height: 120)
                    .background(.blue.opacity(0.1))
                    .border(.blue, width: 2)

                Rectangle()
                    .fill(Color.green.opacity(0.3))
                    .border(.red, width: 2)
                    .frame(width: 240, height: 120)
                    .background(.blue.opacity(0.1))
                    .border(.blue, width: 2)

                Rectangle()
                    .fill(.orange.opacity(0.3))
                    .frame(width: 300, height: 80)
                    .border(.red, width: 2)
                    .frame(width: 240, height: 120)
                    .clipped()
                    .background(.blue.opacity(0.1))
                    .border(.blue, width: 2)
            }
            .padding()
            .overlay(alignment: .topLeading) {
                Text("frame settings")
                    .font(.caption)
            }

            HStack(alignment: .top, spacing: 12) {
                Rectangle()
                    .fill(.orange.opacity(0.4))
                    .frame(width: 80, height: 60)
                    .border(.red, width: 2)
                Rectangle()
                    .fill(.green.opacity(0.4))
                    .frame(width: 100, height: 90)
                    .border(.green, width: 2)
            }
            .overlay(alignment: .topLeading) {
                Text("inner 80 + 12 + 100 * 90")
                    .font(.caption)
            }
            .border(.purple, width: 2)
            .frame(width: 360, height: 120)
            .overlay(alignment: .topLeading) {
                Text("outer 360 * 120")
                    .font(.caption)
            }
            .background(.blue.opacity(0.1))
            .border(.blue, width: 2)

            VStack(spacing: 60) {
                ZStack {
                    Rectangle()
                        .fill(.orange)
                        .frame(width: 120, height: 80)
                    Rectangle()
                        .fill(.green)
                        .frame(width: 60, height: 160)
                }
                .border(.blue, width: 2)

                Rectangle()
                    .fill(.orange)
                    .frame(width: 120, height: 80)
                    .overlay {
                        Rectangle()
                            .fill(.green)
                            .frame(width: 60, height: 160)
                    }
                    .border(.blue, width: 2)
            }

        }
    }
}

#Preview {
    LayoutBasicsLabView()
}

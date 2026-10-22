//
//  ClippingMaskLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/22/26.
//

import SwiftUI

struct ClippingMaskLabView: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Rectangle()
                        .fill(.orange)
                        .frame(width: 280, height: 120)
                        .border(.red, width: 4)
                        .frame(width: 180, height: 80)
                        .clipped()
                        .border(.red, width: 4)
                        .overlay(alignment: .center) {
                            Text("자르기 전 영역의 \n레이아웃을 그대로 가짐")
                                .font(.system(size: 30, weight: .semibold, design: .rounded))
                                .lineLimit(2)
                                .minimumScaleFactor(0.2)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    Image("LabPhoto")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 120)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 16)
                        )
                    Image("LabPhoto")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(alignment: .bottomLeading) {
                            Circle()
                                .fill(.green)
                                .frame(width: 24)
                        }
                }
                HStack {
                    //                    Image("LabPhoto")
                    //                        .resizable()
                    //                        .scaledToFill()
                    //                        .frame(height: 120)
                    //                        .clipShape(
                    //                            RoundedRectangle(cornerRadius: 16)
                    //                        )
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .mask(alignment: .leading) {
                        Rectangle()
                            .frame(width: 80)
                    }
                    .border(.black, width: 4)
                    VStack {
                        Text("오른쪽으로 갈수록 사라짐")
                            .font(.title)
                            .padding()
                            .background(.blue.opacity(0.2))
                            .mask {
                                LinearGradient(
                                    colors: [.black, .clear],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            }
                        LinearGradient(
                            colors: [.blue, .purple, .pink],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(height: 60)
                        .mask {
                            Text("mask로 텍스트 그라디언트 넣기")
                                .font(.system(size: 30, weight: .bold))
                                .minimumScaleFactor(0.2)
                            Text("근데 그럴거면 그냥 텍스트에 효과로 넣는게 나음")
                                .font(.caption)
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ClippingMaskLabView()
}

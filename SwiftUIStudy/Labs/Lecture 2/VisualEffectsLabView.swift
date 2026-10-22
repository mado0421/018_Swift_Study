//
//  VisualEffectsLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/22/26.
//

import SwiftUI

struct VisualEffectsLabView: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 16)
                        .shadow(color: .brown, radius: 2, x: 2, y: 6)
                    RoundedRectangle(cornerRadius: 16)
                        .opacity(0.5)
                        .shadow(radius: 2, x: 2, y: 6)
                    Text("SwiftUI")
                        .font(.largeTitle.bold())
                        .shadow(radius: 0, y: 3)
                        .padding(24)
                        .background(
                            .yellow,
                            in: RoundedRectangle(cornerRadius: 20)
                        )
                    Image("LabPhoto")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80)
                        .mask(Circle())
                        .shadow(radius: 2, x: 2, y: 2)
                        .overlay(alignment: .bottomLeading) {
                            Circle()
                                .fill(Color(hue: 0.35, saturation: 1, brightness: 1))
                                .frame(width: 24)
                        }
                }.frame(height: 80)
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                    HStack {
                        Text("Blur")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)
                            .blur(radius: 1, opaque: true)
                        Text("Blur")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)
                            .blur(radius: 1)
                        ZStack {
                            Circle().fill(.white).padding()
                            Circle().fill(.white).padding().offset(x:40)
                        }
                        .compositingGroup()
                        .opacity(0.5)
                        .blur(radius: 2)
                    }
                }.frame(height: 80)
                HStack {
                    Rectangle()
                        .shadow(radius: 4, x: 4, y: 4)
                        .padding(4)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }.frame(height: 80)
            }
            .padding()
        }
    }
}

#Preview {
    VisualEffectsLabView()
}

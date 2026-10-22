//
//  ImageLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/21/26.
//

import SwiftUI

struct ImageLabView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Image Lab")
                    .font(.title)
                    .fontDesign(.rounded)
                    .fontWeight(.semibold)
                Button {
                    print("")
                } label: {
                    Label {
                        Text("레이블")
                    } icon: {
                        Image("LabPhoto")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipped()
                    }
                    .labelStyle(.automatic)
                    .background(.gray)
                }
                .frame(alignment: .center)
                Image(systemName: "person.crop.circle.badge.plus")
                    .font(.system(size: 40, weight: .bold))
                    .imageScale(.large)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.blue)
                Image(systemName: "person.crop.circle.badge.plus")
                    .font(.system(size: 40, weight: .bold))
                    .imageScale(.large)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.green, .blue)
                Image(systemName: "star")
                    .font(.system(size: 40, weight: .bold))
                    .imageScale(.large)
                    .symbolVariant(.slash)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.brown)
                Image("LabPhoto")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    .border(.blue)
                    .clipped()
                Image(decorative: "LabPhoto")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 160, height: 160, alignment: .center)
                    .clipShape(Circle())
                    .border(.blue)
            }
            .border(.blue)
        }
        .padding()
        //        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ImageLabView()
}

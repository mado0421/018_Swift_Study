//
//  LayoutBasicsLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/22/26.
//

import SwiftUI

struct LayoutBasicsLabView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24){
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
        .padding(24)
    }
}

#Preview {
    LayoutBasicsLabView()
}

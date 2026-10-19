//
//  BasicViewsLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/18/26.
//

import SwiftUI

struct BasicViewsLabView: View {
    var body: some View {
        VStack(spacing: 20) {  // alignment, spacing 등을 받을 수 있음.
            Image(systemName: "star.fill")
                .font(.system(size: 60))  //  <- View Modifier. 외관이나 동작 관련 설정을 적용하는 메서드.
            Text("SwiftUI Lab")
                .font(.largeTitle)
            Text("Study SwiftUI")
                .fixedSize(horizontal: false, vertical: true)
            Text("Very very very long long long text.")
                .truncationMode(.middle)
                .minimumScaleFactor(0.7)
                .lineLimit(1)
            HStack(spacing: 20) {
                Button("A") { print("A") }
                Button("B") { print("B") }
            }
        }
        .padding(40)
    }
}

#Preview("Basic Views Lab") {
    BasicViewsLabView()
}

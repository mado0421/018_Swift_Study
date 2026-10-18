//
//  ViewAsValueLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/18/26.
//

import SwiftUI

struct MessageView: View {
    let message: String

    // 이게 어떻게 유지되는가? View Identity에 연결된 @State 저장소를 유지하기 때문.
    // MessageView의 값이 갱신된다고 해서 clickCount의 상태 저장소가 무조건 새로 만들어지지 않는다.
    // 같은 위치의 MessageView가 유지되므로 상태가 유지된다.
    @State private var clickCount = 0

    var body: some View {
        VStack(spacing: 10) {
            Text(message)

            Text("Clicks: \(clickCount)")

            Button("Click Me") {
                clickCount += 1
            }
        }
    }
}

struct ViewAsValueLabView: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("View as Value Lab")
                .font(.title)

            MessageView(message: "Count: \(count)")

            Button("Increase Count") {
                count += 1
            }
        }
        .padding(30)
        .frame(minWidth: 400, minHeight: 250)
    }
}

#Preview {
    ViewAsValueLabView()
}

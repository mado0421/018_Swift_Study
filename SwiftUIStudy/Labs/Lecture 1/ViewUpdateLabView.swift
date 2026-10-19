//
//  ViewUpdateLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/19/26.
//

import SwiftUI

struct DynamicTextView: View {
    let count: Int
    
    var body: some View {
        let _ = print("DynamicTextView.body evaluated.")
        Text("Count: \(count)")
            .font(.title2)
    }
}

struct StaticTextView: View {
    var body: some View {
        let _ = print("StaticTextView.body evaluated.")
        Text("Static Text")
    }
}

// ViewUpdateLabView는 count를 소유하고 body에서 이를 읽는다. 따라서 값이 변경될 경우 body가 재평가 될 수 있다.
struct ViewUpdateLabView: View {
    @State private var count = 0

    var body: some View {
        let _ = print("ViewUpdateLabView.body evaluated.")

        VStack(spacing: 20) {
            Text("View Update Lab")
                .font(.title)
//            Text("Count: \(count)")
//                .font(.title2)
//            Text("Static Text")
            
            // 변경된 count 값을 전달받기 때문에 DynamicTextView의 입력값이 변경되었고, 새로운 UI 구성을 계산할 필요가 생김.
            DynamicTextView(count: count)
            
            // 딱히 바뀐게 없음. 자체 상태나 환경 등 다른 의존성도 바뀌지 않았기 때문에 SwiftUI는 count 변화 시에 StaticTextView의 body 재평가를 생략함.
            StaticTextView()

            Button("Increase") {
                count += 1
            }
        }
        .padding()
    }
}

#Preview {
    ViewUpdateLabView()
}

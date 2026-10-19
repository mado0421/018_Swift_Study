//
//  ViewTreeLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/18/26.
//

import SwiftUI

struct CounterItemView: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 10) {
            Text("Count: \(count)")

            Button("Increase") {
                count += 1
            }
        }
        .padding(15)
        .background(.gray.opacity(0.1))
    }
}

struct ViewTreeLabView: View {
//    @State private var isExpanded = false
    @State private var isEnabled = true

    var body: some View {
        VStack(spacing: 20) {
//===========================================
// 1. Modifier 순서로 보여지는 결과 바꾸기
//===========================================
//            Text("Modifier Order")
//                .font(.title)
//
//            Text("Example A")           // Text
//                .padding(20)            // Padding 적용
//                .background(.yellow)    // Padding까지 적용된 것에 Background 적용
//
//            Text("Example B")           // Text
//                .background(.yellow)    // Text에 Background 적용
//                .padding(20)            // Background 적용된 것에 Padding 적용

//===========================================
// 2.
//===========================================
//            VStack(spacing: 20) {
//                Text("Conditional View Tree")
//                    .font(.title)
//
//                Button("Toggle") {
//                    isExpanded.toggle()
//                }
//
//                if isExpanded {
//                    VStack(spacing: 10) {
//                        Text("Item A")
//                        Text("Item B")
//                        Text("Item C")
//                    }
//                } else {
//                    Text("Collapsed")
//                }
//            }
            Text("View Identity Test")
                .font(.title)

            if isEnabled {
                CounterItemView()
            } else {
                CounterItemView()
            }
            
            Button("Toggle") {
                isEnabled.toggle()
            }
        }
        .padding(30)
        .frame(minWidth: 400, minHeight: 300)
    }
}

#Preview {
    ViewTreeLabView()
}

//
//  Lecture1SummaryLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/19/26.
//

import SwiftUI

struct SummaryCounterView: View {
    let title: String

    @State private var count = 0

    var body: some View {
        let _ = print("[\(title)] body evaluated.")

        VStack(spacing: 10) {
            Text(title)
                .font(.headline)

            Text("Count: \(count)")

            Button("Increase") {
                count += 1
            }
        }
        .padding(15)
        .background(.gray.opacity(0.1))
    }
}

struct Lecture1SummaryLabView: View {
    @State private var parentCount = 0
    @State private var isEnabled = true
    @State private var identity = 0
    
    @ViewBuilder
    var statusContent: some View {
        if isEnabled {
            Text("System Enabled")
                .foregroundStyle(.green)
        } else {
            Button("Enable System") {
                isEnabled = true
            }
        }
    }
    
    var body: some View {
        let _ = print("[Parent] body evaluated.")
        
        ScrollView {
            VStack(spacing: 25) {
                Text("Lecture 1 Summary Lab")
                    .font(.title)
                
                VStack(spacing: 10) {
                    Text("A. View Update")
                        .font(.headline)
                    Text("Parent Count: \(parentCount)")
                    SummaryCounterView(title: "Child Counter")
                    Button("Increase Parent") { parentCount += 1}
                }
                
                VStack(spacing: 10) {
                    Text("B. Structural Identity")
                        .font(.headline)
                    if isEnabled {
                        SummaryCounterView(title: "Enabled Counter")
                    } else {
                        SummaryCounterView(title: "Disabled Counter")
                    }
                    Button("Toggle Branch") {
                        isEnabled.toggle()
                    }
                }
                
                VStack(spacing: 10) {
                    Text("C. Explicit Identity")
                        .font(.headline)
                    Text("Current ID: \(identity)")
                    SummaryCounterView(title: "ID Counter")
                        .id(identity)
                    Button("Change ID") {
                        identity += 1
                    }
                }
                
                VStack(spacing: 10) {
                    Text("D. Result Builder & Opaque Type")
                        .font(.headline)

                    statusContent
                }
            }
            .padding(30)
            .frame(maxWidth: .infinity)
        }
        .frame(minWidth: 450, minHeight: 500)
    }
}

#Preview {
    Lecture1SummaryLabView()
}

/*
 SwiftUI
 │
 ├── Declarative UI
 │   └── 상태에 따른 UI를 선언
 │
 ├── View as Value
 │   └── UI 구성을 값 타입으로 표현
 │
 ├── View Tree
 │   └── View들의 계층 구조
 │
 ├── View Identity
 │   ├── Structural Identity
 │   └── Explicit Identity
 │
 ├── View Update
 │   ├── 상태 의존성 추적
 │   ├── body 재평가
 │   └── 실제 UI 갱신
 │
 └── Swift 타입 시스템
     ├── Result Builder
     │   └── 여러 View를 하나의 결과로 구성
     │
     └── Opaque Types
         └── 구체 반환 타입 은닉
 */

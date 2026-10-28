//
//  ContentView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/14/26.
//

import SwiftUI

private enum Lab: Hashable {
    case lecture1
    case lecture2
    case lecture3
}

/*
 앱의 사용자 인터페이스 일부를 나타내는 타입이며, View를 설정할 수 있는 Modifier를 제공하는 프로토콜. 화면을 구성하기 위한 공통 인터페이스.
 Text, Button, VStack 등이 전부 View다. SwiftUI는 하나의 View 안에 다른 View들을 포함시켜 복잡한 화면을 구성할 수 있다.
 View 콘텐츠를 구성하는 빌더 기능이 Xcode 27에 확장됐다는데 자세한건 나중에.
 */
// SwiftUI는 화면을 갱신해야 할 때 View의 body를 다시 평가할 수 있고, 여러번 평가가 될 수도 있음.
// 따라서 body의 내용물은 UI 구성을 선언하는 역할에 집중해야 함.
// 중요한 부수 효과는 생명주기 또는 이벤트 처리 API에서 수행하게 해야 함.
struct ContentView: View {
    @State private var selection: Lab? = .lecture1
    
    var body: some View {
        NavigationSplitView {
            sidebar
        } detail: {
            selectedLab
        }
    }
    
    private var sidebar: some View {
        List(selection: $selection) {
            Text("Lecture 1").tag(Lab.lecture1)
            Text("Lecture 2").tag(Lab.lecture2)
            Text("Lecture 3").tag(Lab.lecture3)
        }
        .listStyle(.sidebar)
        .navigationTitle("SwiftUI Lab")
    }
    
    @ViewBuilder
    private var selectedLab: some View {
        switch selection {
        case .lecture1:
            Lecture1SummaryLabView()
        case .lecture2:
            Lecture2SummaryLabView()
        case .lecture3:
            Lecture3SummaryLabView()
        case nil:
            Text("왼쪽 목록에서 실습을 선택하세요.")
                .foregroundStyle(.secondary)
                .padding()
        }
    }
    
}

// #Preview는 Swift의 freestanding declaration macro. 독립적인 선언 위치에서 사용. 컴파일 과정에 Preview에 필요한 코드를 생성.
// #Preview(name: String?) { View를 생성하는 Closure } 같은 형태.
// Live 모드에서는 버튼 클릭이나 텍스트 입력이 된다.
// Selectable 모드에서는 Canvas의 UI 요소를 선택하여 해당 Swift 코드 위치를 찾을 수 있음.
#Preview("Default") {
    ContentView()
}
#Preview("Dark") {
    ContentView()
        .preferredColorScheme(.dark)
}
//#Preview("Small Font"){
//    Text("SwiftUI")         // <- Text도 View protocol을 준수하기 때문에 가능.
//        .font(.caption)     // 근데 이렇게 하면 Selectable에서 선택이 안되는 듯.
//        .padding()
//}

// View의 크기 및 레이아웃을 변경할 때는 .frame(width:height:)
// Preview의 크기 및 레이아웃을 변경할 때는 .fixedLayout(width:height:)
// macOS 창의 기본 크기를 설정할 때는 .defaultSize(width:height)
// SwiftUI의 레이아웃 시스템은 부모가 자식에게 크기를 제안하고, 자식이 그 제안과 자신의 콘텐츠 및 레이아웃 규칙에 따라 크기를 결정하는 방식으로 동작.
//#Preview(
//    "Fixed Size",
//    traits: .fixedLayout(width: 10, height: 500)   // 표시 조건이나 동작 특성을 지정
//) {                                                 // Point 단위. != Pixel
//    ContentView()
//        .preferredColorScheme(.dark)
//}
/*
 Window, View, Layout, Container는 다음과 같이 이해할 수 있다.
 - Window: macOS가 관리하는 애플리케이션 창. 창의 크기가 800*500이라고 내부의 모든 View가 800*500인 것이 아니다.
 - View: UI를 구성하는 기본 단위. Text도 View고, Button도 View고, VStack도 View.
 - Layout: View들의 크기와 위치를 결정하는 과정 및 결과.
 - Container: 다른 View를 내부에 포함하고 배치하는 구성 요소. VStack, HStack, ZStack, Grid 등.
 
 Layout에 대해.
 SwiftUI는 각 Content가 어느 정도의 크기를 필요로 하는지, View 사이의 간격은 얼마인지, 각 Content를 어디에 배치할 것인지, 전체 Container의 크기는 얼마인지 등을 계산함. 이게 Layout.
 
 그 외에 Frame, Content, Proposed Size 등이 있음
 - Frame: View의 레이아웃상 크기와 위치를 나타내는 사각형.
 - Content: View 내부에 표시하거나 포함하는 내용.
 - Proposed Size: 부모가 자식에게 레이아웃 과정에서 제안하는 크기.

 SwiftUI의 .frame(width:height:)는 원래 View를 감싸는 Layout View를 만듦.
 */

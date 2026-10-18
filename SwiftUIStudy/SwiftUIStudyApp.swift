//
//  SwiftUIStudyApp.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/14/26.
//

import SwiftUI

@main   // @main은 이 타입이 프로그램의 진입점을 제공한다는 것을 컴파일러에게 알려줌.
        // 컴파일러는 @main이 붙은 타입의 main() 함수를 프로그램의 진입점으로 사용.

struct SwiftUIStudyApp: App {   // protocol App에서 main()을 제공하고 있기 때문에
                                // SwiftUIStudyApp에 main()이 구현되어 있지 않아도
                                // 실행에 문제가 없다.
    
    // App과 Window의 생명주기는 서로 다르다.
    // 아래는 App의 생명주기 중 초기화 구문이고, 창은 별개이다.
    // 새 창을 연다고 해서 App의 초기화 구문이 불리지 않는다.
    init() {
        print("SwiftUI App initialized.")
    }
    
    // Scene은 시스템이 생명주기를 관리하는 앱 UI의 일부. 하나의 구성 단위.
    // Scene은 WindowGroup, Window, Settings, DocumentGroup 등이 있다.
    //
    // Scene은 UI가 어디에, 어떤 생명주기로 나타나는지를 정의하고,
    // View는 그 안에 무엇을 표시할지 정의한다.
    
    // body는 compute property. some Scene을 반환한다.
    // get {}이 생략되어 이런 모습.
    // WindowGroup {}도 정확히는 init(@ViewBuilder content: @escaping ()-> Content)
    var body: some Scene {
        WindowGroup {       // WindowGroup은 동일한 구조의 창들을 제공하는 Scene
                            // 새 창을 열면 동일한 구조의 창들을 여럿 열 수 있다.
                            // 각 창은 같은 ContentView 타입으로 구성되지만 별개의 View 계층과
                            // 창별 상태를 가질 수 있다.
                            // 예를 들어 @State로 관리하는 값은 일반적으로 각 창에서 독립적 유지.
            
            ContentView()   // ContentView는 protocol View를 준수하는 구조체.
                            // body는 해당 View가 어떤 UI로 구성되는지를 정의한다.
                            // 각 Window 내부에 표시되는 UI를 담당.
        }
    }
}

/* 대략적인 앱 시작 개념도
 macOS에서 앱 실행 -> @main 진입점 -> App.main() -> SwiftUIStudyApp 초기화
 -> App의 Scene 구성 처리 -> WindowGroup을 바탕으로 창 생성 -> ContentView 표시
 -> 사용자 이벤트 처리
 */

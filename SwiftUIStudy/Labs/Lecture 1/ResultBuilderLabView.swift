//
//  ResultBuilderLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/19/26.
//

import SwiftUI

@resultBuilder
struct NumberBuilder {
    // Int를 인자로 받는데 이건 [Int]가 아니니까 [Int]로 바꿔주는 메서드.
    static func buildExpression(_ number: Int) -> [Int] {
        [number]
    }

    static func buildBlock(_ components: [Int]...) -> [Int] {
        components.flatMap { $0 }
    }

    static func buildOptional(_ component: [Int]?) -> [Int] {
        component ?? []
    }
}

func makeNumbers(
    @NumberBuilder content: () -> [Int]
) -> [Int] {
    content()
}

func testNumberBuilder() {
    let numbers = makeNumbers {
        10
        20
        30
        if true {
            40
        }
    }

    print(numbers)
}

struct LabContainer<Content: View>: View {
    let title: String
    let content: Content

    init(
        title: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(spacing: 15) {
            Text(title)
                .font(.headline)

            content
        }
        .padding(20)
        .background(.gray.opacity(0.1))
    }
}

struct ResultBuilderLabView: View {
    @State private var showDetails = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Custom Container")
                .font(.title)

            LabContainer(title: "My Container") {
                Text("First View")

                Text("Second View")

                if showDetails {
                    Text("Additional Information")
                }
            }

            Button("Toggle Details") {
                showDetails.toggle()
            }
        }
        .padding(30)
        .frame(minWidth: 400, minHeight: 350)
    }
}

#Preview {
    ResultBuilderLabView()
}

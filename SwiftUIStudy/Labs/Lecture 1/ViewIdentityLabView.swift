//
//  ViewIdentityLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/18/26.
//

import SwiftUI

struct IdentityCounterView: View {
    let title: String

    @State private var count = 0

    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.title2)

            Text("Count: \(count)")

            Button("Increase") {
                count += 1
            }
        }
        .background(.gray.opacity(0.1))
    }
}

struct ViewIdentityLabView: View {
    @State private var players = [
        Player(id: 1, name: "Alice"),
        Player(id: 2, name: "Bob"),
        Player(id: 3, name: "Charlie")
    ]

    var body: some View {
        VStack() {
            Text("ForEach Identity")
                .font(.title)

            ForEach(players) { player in
                IdentityCounterView(title: player.name)
            }

            Button("Reverse Order") {
                players.reverse()
            }
            
            Button("Change Alice ID") {
                // .firstIndex는 Self.Index?을 반환함. 따라서 Optional Binding으로 새 변수에 넣는다.
//                if let index = players.firstIndex(where: { $0.name == "Alice" })
//                {
//                    players[index].id += 100
//                }
                if let index = players.firstIndex(where: { player in
                    return player.name == "Alice"
                }) {
                    players[index].id += 100
                }
                /*
                 players.firstIndex(where: { (player: Player) -> Bool in
                     return player.name == "Alice"
                 })를 축약해서
                 players.firstIndex(where: { $0.name == "Alice" })가 된다.
                 진짜 어렵다. 증말.
                 
                 1. firstIndex(where:)가 요구하는 함수 타입이 존재하기 때문에 타입 추론이 가능.
                 2. 단일 표현식이라 return 생략 가능.
                 3. 매개변수 이름 생략하고 $0, $1, ... 등으로 접근.
                 */
            }
        }
        .padding(30)
    }
}

// Identifiable은 데이터가 안정적인 식별자를 제공하도록 하는 프로토콜.
struct Player: Identifiable {
    var id: Int // <- 이게 Identifiable의 requirement.
    let name: String
}

#Preview {
    ViewIdentityLabView()
}

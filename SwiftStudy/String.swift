//
//  main.swift
//  SwiftStudy
//
//  Created by 신재욱 on 10/14/26.
//

/*
import Foundation

// String은 다음과 같이 선언한다.
let constantString = "Hello World!"

// 단일글자 Character 또한 ""로 선언하되, 타입을 명시하지 않으면 String으로 타입 추론이 되므로
// Character라고 타입을 명시해줘야 한다.
let constantCharacter: Character = "H"

// Swift의 Character와 String은 Unicode 기준으로 동작한다.
// 더 정확히는 Character는 "A", "가", "🧑‍🧑‍🧒" 모두 한 글자다!!!
// Character 하나가 1 byte라고 보장할 수 없다!!!
// 따라서 constantString[0]과 같이 subscript를 사용한 접근이 불가능하다.
// let stringSubscriptTest = constantString[0]  // 'subscript(_:)' is unavailable:
                                                // cannot subscript String with an Int, use a String.Index instead.
// 따라서 constantString.first와 같이 접근하거나, for로 순회하는 식으로 접근해야 한다.
let constantCharacter2 = constantString.first!

// Character는 String을 for문으로 순회하면 나온다. 키 입력, 명령 문자, 구분자, 기호, 문자열 순회, 파싱, 텍스트 알고리즘 등에서 사용한다는 듯?
for character in constantString {
    // ...
}

// 하나의 Character는 하나 또는 다수의 unicode scalar로 이루어질 수 있다.
// unicode scalar는 unicode가 정의한 하나의 값... UTF-8 code unit...(UInt8 단위?)
// 👶+🧑+🧑=🧑‍🧑‍🧒 뭐 이런게 되나보다. 정말 신기하다.
let adult: Character = "🧑"
let child: Character = "🧒"
let family = String(adult) + "\u{200D}" + String(adult) + "\u{200D}" + String(child)    // 5개의 unicode scalar를 합.
print(family)                       // 🧑‍🧑‍🧒
print(family.unicodeScalars.count)  // 5

// 사람이 글자로 인식하는 최소 단위(A, 가, 한, è 등)를 grapheme[그래핌]이라 한다.
// 여러 scalar를 모아서 화면상 하나의 글자로 취급하도록 판단하는 규칙이 grapheme cluster.
// 그 중에서도 Extended 버전을 현대 Swift가 사용한다는 것 같다.

// String은 [Character]가 아니다!!!
// Swift의 String은 문자열 내용을 UTF-8 code unit 형태로 저장한다.
// 대략 UTF-8 code unit 15개까지의 작은 문자열은 heap allocation 없이 String 값 내부에 직접 저장한다. ex) "Hello" + 길이/상태 정보 등
// 그 이상의 큰 문자열은 별도의 storage class에 의해 backing되며 문자열 내용이 그 객체 뒤에 연속적으로 배치된다고 함.

// UTF-8 code unit들을 필요할 때 Unicode 규칙에 따라 해석함.
// UTF-8 code unit -> Unicode scalar -> Extended Grapheme Cluster -> 사람이 보는 글자
// String의 문자 개수를 알려면 EGC의 경계 판단이 필요함. 글자들을 따라가며 확인.

// 결론
// 'Character는 4 byte' 이런 식으로 생각하면 곤란함.
// 'String은 Character들의 연속된 배열'이라고 생각하면 곤란함.
*/

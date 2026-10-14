//
//  SwiftBasic.swift
//  SwiftStudy
//
//  Created by 신재욱 on 10/14/26.
//

/*
import Foundation

//===============================
// 상수와 변수
//===============================

let constant = 0                // 상수는 let을 사용. let x y의 형식.

let constantInteger = 0         // constantInteger는 타입 추론(type inference)이 된다.
                                // 여기선 컴파일러가 값을 추론하여 Int가 된다.
let constantInterger2: Int = 0  // 이렇게 직접 타입을 적어줄 수도 있다.

let constantFloat: Float = 0    // 부동소수점은 기본적으로 Double로 추론되기 때문에
                                // Float로 만들기 위해선 Float라고
                                // 컴파일러에게 알려줄 필요가 있다.

var variable = 0                // 변수는 var를 사용.
                                // 위의 0 같은 값들은 literal이라 한다.
                                // integer, floating-point, string, boolean, ...

                                // Swift의 Int는 실행 플랫폼의 native word size
variable = Int.bitWidth         // 일반적인 64비트 macOS에서는 64비트 정수.
var variableInt8 = Int8.min     // Int8, UInt64 등도 있다.
var variableUInt64 = UInt64.max

//===============================
// 반복
//===============================
// Swift의 반복은 for-in, while, repeat-while이 있다. C/C++, C#과 비슷함
let numbers = 0...10    // 범위를 이렇게 표현하다니 신기!

// for-in
for number in numbers {
    print(number)
}

// 횟수만 중요하고 값이 필요 없다면 _를 이용하여 버릴 수 있다.
for _ in numbers {
    print("just count!")
}

// while
var count = 0
while 1 > count {   // true인 동안 계속 실행.
    count += 1
}

// repeat-while
repeat {            // 일단 repeat를 한 번 실행하고 조건을 검사한 뒤 만족하면 repeat를 반복한다.
    count += 1      // do-while과 비교하면 '만족하면 이걸 해라'와 '만족하면 반복해라'의 느낌의 차이가 있다.
} while 0 > count   // 개인적으론 repeat-while이 좀 더 느낌이 맞는것 같기도 함.

// ++ 연산자가 없기 때문에 i++를 지원하는 문법이 없다. 범위나 컬렉션 순회는 for-in이 기본.
// break와 continue는 C/C++, C#과 동일하다.

//===============================
// 조건
//===============================
// if는 C와 비슷.
// switch가 조금 다르다.
// Swift에서는 switch문에 break가 필요 없다. 기본적으로 fallthrough가 없다.
// 원하면 fallthrough를 사용하여 쓸 수 있으나 잘 쓰이지 않는다고 함.

let numberForSwitch = Int.random(in: 0...30)    // ⌃⌘E 눌러서 스코프 내의 이름을 한 번에 바꿀 수 있다.
switch numberForSwitch {
case 0:                 // fallthrough를 쓰면 case 1의 내용까지 실행된다.
    print("0")
    fallthrough
case 1:                 // 1일 때 실행된다.
    print("1")
case 2..<10:            // 후술할 범위 패턴을 사용할 수 있다!
    print("many")
case 10...20, 20...30:  // 여러 값을 한 case에 쓸 수 있다!
    print("many many")
default:                // Swift는 가능한 모든 값들을 전부 포함하지 않으면 컴파일 에러가 난다.
    print("default")
}

// 나중에 설명할 튜플을 사용할 수도 있다.
let tupleForSwitch = (Int.random(in: 0...30), Int.random(in: 0...30))
switch tupleForSwitch {
case (0, 0):                    // 위에서부터 검사한다.
    print("원점 위")
case (0, _):                    // _를 이용하여 '이 자리의 값은 신경쓰지 않는다'를 할 수 있다!
    print("x축 위")
case (_, 0):
    print("y축 위")
case let (x, y) where x == y:   // where도 된다!
    print("y = x 방정식 선 위")
case (_, _):
    print("어딘가")
}

//===============================
// 간단 형변환 규칙
//===============================
// Swift는 암시적 타입 변환을 매우 보수적으로 다룸.
// let numberResult = constantInteger + constantFloat   // Binary operator '+' cannot be applied to
                                                        // operands of type 'Int' and 'Float'
let numverResult = constantInteger + Int(constantFloat) // 이렇게 타입 변환(type conversion)을 해줘야 함


// Swift는 boolean으로 자동 형변환하여 사용하는 것이 안됨.
/*
if constant {   // Type 'Int' cannot be used as a boolean; test for '!= 0' instead
    // ...
}
 */
if 0 == constant {
    // ...
} else if 1 == constant {
    // ...
} else {
    // ...
}

//===============================
// 범위
//===============================
let closedRange = 1...5         // 이 때 closedRange의 자료형은 ClosedRange<Int>다!(우와
let halfOpenRange = 1..<5       // 이건 Range<Int>
let doubleRange = 0.0...10.0    // 이건 ClosedRange<Double>

// 범위를 표현하는 연산자 a...b, a..<b, ...b, ..<b, a... 등이 있다.
let number = 0
switch number {
case ...(-10): fallthrough  // -10 이하
case ..<0: fallthrough      // 0 미만
case 0..<10: fallthrough    // 0 이상 10 미만
case 10...20: fallthrough   // 10 이상 20 이하
case 21...: fallthrough     // 21 이상
default: print(number)
}

// a~=b b가 패턴 a에 맞는지 여부를 반환하는 연산자가 있다. 패턴 매칭 연산자라고 함.
if (-10)...10 ~= number {
    print(number)
}

// Range<Int>는 for value in range { ... } 와 같이 순회 가능
// Range<Double>은 stride(from: through: by:)를 사용하여 일정 간격으로 순회할 수 있다.

//===============================
// 연산자
//===============================
// 연산자는 C/C++, C# 등과 대부분 비슷함
// ++, -- 같은 연산자 없다!!!

// class 등의 객체에 한정하여 identity 동일성을 확인하는 ===가 있다.
class SomeClass {
    var contents = 0
}
let someClassA = SomeClass()
let someClassB = someClassA
print(someClassA === someClassB)    // true




*/

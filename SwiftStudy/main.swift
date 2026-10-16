//
//  main.swift
//  SwiftStudy
//
//  Created by 신재욱 on 10/14/26.
//

import Foundation

//=============================================================================
// XCode 단축키
//=============================================================================
// ⌃⇧I Format File with 'swift-format'
// ⌃⌥⇧I Format Selection with 'swift-format'
// ⌃⌘E 눌러서 스코프 내의 이름을 한 번에 바꿀 수 있다.

//=============================================================================
// 기본 문법
//=============================================================================

let constant = 0  // 상수는 let을 사용. let x y의 형식.

let constantInteger = 0  // constantInteger는 타입 추론(type inference)이
// 된다.
// 여기선 컴파일러가 값을 추론하여 Int가 된다.
let constantInterger2: Int = 0  // 이렇게 직접 타입을 적어줄 수도 있다.

let constantFloat: Float = 0  // 부동소수점은 기본적으로 Double로 추론되기 때문에
// Float로 만들기 위해선 Float라고
// 컴파일러에게 알려줄 필요가 있다.

var variable = 0  // 변수는 var를 사용.
// 위의 0 같은 값들은 literal이라 한다.
// integer, floating-point, string, boolean, ...

// Swift의 Int는 실행 플랫폼의 native word size
variable = Int.bitWidth  // 일반적인 64비트 macOS에서는 64비트 정수.
var variableInt8 = Int8.min  // Int8, UInt64 등도 있다.
var variableUInt64 = UInt64.max

// Swift는 암시적 타입 변환을 매우 보수적으로 다룸.
// let numberResult = constantInteger + constantFloat   // Binary operator '+' cannot be applied to
// operands of type 'Int' and 'Float'
let numverResult = constantInteger + Int(constantFloat)  // 이렇게 타입 변환(type conversion)을 해줘야 함

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

print("constant: \(constant)")  // 문자열 내 값 삽입, 문자열 보간(String Interpolation)

// type(of: 확인하고 싶은 대상)을 하면 대상의 런타임 타입? 동적 타입? 실제 값?을 알 수 있다. 정적 타입은 아님. 그 차이는 후술한다.
print("type(of: stringIndex): \(type(of: stringIndex))")  // Swift의 함수들은 매개변수 이름과 별도인 인수 라벨을 갖는데(예를 들어 type(of))
// 이를 통해 말하듯이 작성할 수 있다.
// 그래서 영어를 잘해야 할 것 같음.

// Int? 같이 타입 뒤에 붙이는 ?는 Optional 표시.
// value!는 force unwrap.
// player?.name은 optional chaining. 만약 player가 nil이면 이어지는 name의 접근을 허용하지 않고 전체 결과를 nil로 만듦.
// String!은 implictly unwrapped optional
// ->는 함수 반환 타입을 나타내는 표현. foo() -> Void 와 같이 사용.
// @MainActor의 @는 attribute.
// #available의 #는 complier directive/special syntax

//=============================================================================
// String과 Character
//=============================================================================
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
    print("character is \(character)")
}

// 하나의 Character는 하나 또는 다수의 unicode scalar로 이루어질 수 있다.
// unicode scalar는 unicode가 정의한 하나의 값... UTF-8 code unit...(UInt8 단위?)
// 👶+🧑+🧑=🧑‍🧑‍🧒 뭐 이런게 되나보다. 정말 신기하다.
let adult: Character = "🧑"
let child: Character = "🧒"
let family =
    String(adult) + "\u{200D}" + String(adult) + "\u{200D}" + String(child)  // 5개의 unicode scalar를 합.
// 여기서 \u{XXXX}는 Unicode 입력을 하는 방법
print("family: \(family)")  // 🧑‍🧑‍🧒
print("family.unicodeScalars.count: \(family.unicodeScalars.count)")  // 5

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

let stringIndex = constantString.startIndex  // 이 때 stringIndex의 타입은 StringIndex (우와
let characterByIndex = constantString[stringIndex]  // characterByIndex의 타입은 Character

//=============================================================================
// 연산자
//=============================================================================
// 대부분의 산술 연산자는 다른 언어와 동일하다. 단, 오버플로우 등이 발생하면 오류를 던짐.
// 오버플로우를 허용하는 연산자가 따로 있다! (우와!) Overflow wraparound를 적용한다고 함.
print("Int.max &+ Int.max: \(Int.max &+ Int.max)")
print("Int.min &- Int.max: \(Int.min &- Int.max)")
print("Int.max &* Int.max: \(Int.max &* Int.max)")

// 범위는 아래처럼 표현할 수 있다. 와!
let closedRange = 1...5  // 이 때 closedRange의 자료형은 ClosedRange<Int>다!(우와
let halfOpenRange = 1..<5  // 이건 Range<Int>
let doubleRange = 0.0...10.0  // 이건 ClosedRange<Double>

// 범위를 표현하는 연산자 a...b, a..<b, ...b, ..<b, a... 등이 있다.
let number = 0
switch number {
case ...(-10): fallthrough  // -10 이하
case ..<0: fallthrough  // 0 미만
case 0..<10: fallthrough  // 0 이상 10 미만
case 10...20: fallthrough  // 10 이상 20 이하
case 21...: fallthrough  // 21 이상
default: print("number: \(number)")
}

// a~=b b가 패턴 a에 맞는지 여부를 반환하는 연산자가 있다. 패턴 매칭 연산자라고 함.
if (-10)...10 ~= number {
    print("number: \(number)")
}

// Range<Int>는 for value in range { ... } 와 같이 순회 가능
// Range<Double>은 stride(from: through: by:)를 사용하여 일정 간격으로 순회할 수 있다.

// 객체의 identity가 동일한지 여부를 반환하는 연산자 ===(반대는 !==)가 있다. 같은 class instance인지 반환함.
// 자세한 내용은 struct와 class에서 설명

// nil 처리를 하는 연산자가 있다.
let optionalValue: Int? = nil
let someValue = optionalValue ?? 0  // optionalValue의 값이 존재하면 그 값을 someValue에 넣고,
// optionalValue의 값이 존재하지 않으면 오른쪽의 값을 넣는다.
print("someValue: \(someValue)")

//=============================================================================
// 반복
//=============================================================================
// Swift의 반복은 for-in, while, repeat-while이 있다. C/C++, C#과 비슷함
let numbers = 0...10  // 범위를 이렇게 표현하다니 신기!

// for-in
for number in numbers {
    print("number: \(number)")
}

// 횟수만 중요하고 값이 필요 없다면 _를 이용하여 버릴 수 있다.
for _ in numbers {
    print("just count!")
}

// while
var count = 0
while 1 > count {  // true인 동안 계속 실행.
    count += 1
}

// repeat-while
repeat {  // 일단 repeat를 한 번 실행하고 조건을 검사한 뒤 만족하면 repeat를 반복한다.
    count += 1  // do-while과 비교하면 '만족하면 이걸 해라'와 '만족하면 반복해라'의 느낌의 차이가 있다.
} while 0 > count  // 개인적으론 repeat-while이 좀 더 느낌이 맞는것 같기도 함.

// ++ 연산자가 없기 때문에 i++를 지원하는 문법이 없다. 범위나 컬렉션 순회는 for-in이 기본.
// break와 continue는 C/C++, C#과 동일하다.

//=============================================================================
// 조건
//=============================================================================
// if는 C와 비슷.
// switch가 조금 다르다.
// Swift에서는 switch문에 break가 필요 없다. 기본적으로 fallthrough가 없다.
// 원하면 fallthrough를 사용하여 쓸 수 있으나 잘 쓰이지 않는다고 함.
let numberForSwitch = Int.random(in: 0...30)
switch numberForSwitch {
case 0:  // fallthrough를 쓰면 case 1의 내용까지 실행된다.
    print("numberForSwitch is 0 + fallthrough")
    fallthrough
case 1:  // 1일 때 실행된다.
    print("numberForSwitch is 1")
case 2..<10:  // 후술할 범위 패턴을 사용할 수 있다!
    print("many")
case 10...20, 20...30:  // 여러 값을 한 case에 쓸 수 있다!
    print("many many")
default:  // Swift는 가능한 모든 값들을 전부 포함하지 않으면 컴파일 에러가 난다.
    print("default")
}

// 나중에 설명할 튜플을 사용할 수도 있다.
let tupleForSwitch = (Int.random(in: 0...30), Int.random(in: 0...30))
switch tupleForSwitch {
case (0, 0):  // 위에서부터 검사한다.
    print("원점 위")
case (0, _):  // _를 이용하여 '이 자리의 값은 신경쓰지 않는다'를 할 수 있다!
    print("x축 위")
case (_, 0):
    print("y축 위")
case (let x, let y) where x == y:  // where도 된다!
    print("y = x 방정식 선 위")
case (_, _):
    print("어딘가. tupleForSwitch is \(tupleForSwitch)")
}

//=============================================================================
// 함수
//=============================================================================
// Swift의 함수는 argumentLabel이라는 것이 있다. 이걸 사용하여 말하듯이 구문을 작성할 수 있음.
// argumentLabel은 함수에 인수를 전달할 때 그 인수의 이름으로 사용되는 것.
// 전달된 인자는 함수 내부에서 매개변수 이름으로 불리며 사용된다.
func functionName(argumentLabel parameterName: Int) -> Void {}  // 이게 함수의 기본형
functionName(argumentLabel: 10)

// 만약 argumentLabel을 붙이지 않으면 parameterName으로 사용하게 된다.
func exampleFunction0(parameter: Int) -> Void {}
exampleFunction0(parameter: 10)

// argumentLabel이나 parameterName을 쓰고 싶지 않다면 _를 사용한다.
func exampleFunction1(_ parameter: Int) -> Void {}
exampleFunction1(0)

// 반환값이 Void일 경우 생략 가능
func exampleFunction2() {}

// 무언가 반환해야 할 때 함수의 길이가 한 줄이라면 return을 생략할 수 있다!!!
func exampleFunction3() -> (first: Int, second: Int) { (100, 100) }

// 매개변수의 기본값은 default value 써서 표현
func exampleFunction4(_ parameter: Int = 10) {}

// parameter는 기본적으로 상수. 필요하면 지역 변수를 새로 만들어서 담고 수정하며 사용해야 함.
// 같은 이름으로 변수를 만들면 shadowing이 발생한다. 필요에 따라 쓸 것.
// 원본값을 수정하고 싶다면 func foo(_ param: inout Int) {} 같이 함수를 선언하고, 호출 시에 인자에 &를 붙일 것.

//=============================================================================
// Optional Binding (if let, guard let, while let)
//=============================================================================
// if나 guard 등의 조건 위치에서 let을 이용하여 Optional을 풀어내는 문법.
// Optional Binding은 일단 값이 있는지 검사하고, 있으면 '값을 꺼내서' '새 변수에 저장'한다.
if let optionalValue {}             // 와 같이 사용 가능.
if let value = optionalValue {}     // 위와 같은 뜻이다.

// 만약 밖 스코프의 변수와 동일한 이름의 변수를 선언할 경우, 밖 스코프의 변수가 가려진다. 이를 Shadowing이라고 함.
let exampleOption: String? = "Hellow Wolrd!"
if let exampleOption = exampleOption {
    print("exampleOption is \(type(of: exampleOption))")
}

// 'let optionalValue'라는 표현이 bool 타입을 반환하거나 하는 것이 아니다.
// Swift의 if는 단순히 Boolean condition만 받는 것이 아니다. condition list를 받을 수 있음.
// 예를 들어 Optional binding, Pattern matching, Availablility check 등.
// guard와 while도 if와 마찬가지.

//=============================================================================
// Collection과 Tuple
//=============================================================================
// Collection은 구체적인 자료구조가 아니라 protocol.
// Array - 순서 존재, 중복 허용, 정수 기반 인덱싱 가능. Array<Int>, [Int]
let array = [10, 20, 30]

// let 배열은 배열 변경 불가. var 배열은 요소 값 변경 가능.
var variableArray = [10]
variableArray.append(20)
variableArray.append(contentsOf: [30, 40])
variableArray.insert(15, at: 1)
variableArray.remove(at: 1)
variableArray.removeLast()
variableArray.removeAll()
print("variableArray.count is \(variableArray.count)")
print("variableArray.isEmpty is \(variableArray.isEmpty)")
for variable in variableArray {}


// Set - 중복 없음, 배열식 순서 개념 없음, 빠른 membership 검사. Swift에서는 Collection에 있다는걸 membership이 있다고 표현하는 듯.
let set: Set<Int> = [0, 1, 2]

// Dictionary - Ket Value 관계를 저장.
let dictionary = ["Fisrt": 100, "Second": 200]  // 타입은 Dictionary<String, Int>, 축약은 [String: Int]

// String도 Collection이다. 단, 인덱스 타입이 String.index임.
// String은 [Character, Character, Character, ...] 이런게 아님. UTF-8 byte sequence.

// Tuple - 여러 값을 하나의 묶음으로 임시 결합한 값. 주로 함수 반환 시에 사용.
let tuple = ("String", 100, 50.0)
print("tuple.0 is \(tuple.0)")  // 각 요소는 .0, .1 과 같이 접근 가능하다.

// 각 요소에 이름을 붙일 수 있다.
let namedTuple = (name: "String", hp: 100, exp: 50.0)
print("namedTuple.name is \(namedTuple.name)")

// Tuple을 분해(destructuring) 할 수 있다.
// 분해 시에 필요 없는 값은 _로 버릴 수 있다.
// 분해는 왼값과 오른값의 구조가 동일해야 하고, 위치 순서 기반으로 받는다.
let (string, _, _) = namedTuple
print("string is \(string)")


//=============================================================================
// struct와 class, value type과 reference type
//=============================================================================
// 대부분의 개념은 다른 언어와 비슷. 다른 부분만 설명하면 다음과 같다.
// Swift는 struct에 대해 자동으로 initializer를 만들어준다.
struct ExampleStruct {
    var hp: Int
}

let exampleStruct0 = ExampleStruct(hp: 100)
let exampleStruct1 = exampleStruct0     // 대입 시 복사 생성. 독립적인 값 생성.

// Swift의 struct에서 객체 내 property는 해당 struct의 구성 요소이며,
// Swift의 관점에서는 property 하나만 바꿔도 그 struct 값이 변한 것으로 취급한다.
// let은 그 값을 '고정'하므로 let player = Player(hp: 100)은
// pleyer라는 binding에 들어있는 Player 값을 변경하지 말라는 뜻이 된다.
// 즉, let + value type은 그 value 전체가 immutable이 된다!!!

// 동등성 비교
// Swift에서 동등성 비교를 위해선 Equatable protocol을 채택하면 된다.
// 자세한 내용은 https://jeong9216.tistory.com/466 를 참고하면 될 듯.
// 정리하면 non-Optional과 Optional의 비교 시, non-Optional을 Optional로 wrap하여 비교한다는 것 같다.

// struct는 identity가 필요없는 데이터 모델을 표현할 때 사용한다.

// struct는 상속이 불가능하다!!!!!!!!!!!!! 상속은 class만 할 수 있다. class도 하나만 상속할 수 있음.
// protocol은 제한 없이 채택 가능.

// class는 initializer를 직접 만들어줘야 한다.
class ExampleClass {
    var hp: Int

    init(hp: Int) {
        self.hp = hp
    }
}

// class는 reference type이기 때문에 대입 생성을 하면 객체를 복사하여 추가로 생성한 것이 아니라
// 같은 객체를 가리키는 reference를 하나 더 만드는 것이 된다.

// 동등성 비교
// struct와 동일하게 Equatable을 채택하면 된다. 단, intializer처럼 ==연산자를 직접 작성해줘야 함.

// class는 여러 곳에서 하나의 객체를 공유할 때 사용을 고려하면 된다.
// 객체의 identity가 중요하고, 상속이 필요할 때 사용한다.
// ARC 기반 reference lifetime.

//=============================================================================
// 상속
//=============================================================================
// 먼저 용어와 실제 영어 표현을 정리하면 다음과 같다.
// 상속           inheritance. Player inherits from Character. inherit from ~
// 부모/자식       superclass/subclass
// 프로토콜 채택    adopt a protocol. protocol을 타입 선언에 추가.
// 프로토콜 준수    conform to a protocol. protocol 요구사항을 만족.
// 요구사항        requirement. protocol이 요구하는 property/method 등.
// 구현           implementation. 실제 동작 코드를 작성.
// 재정의          override. 상속 받은 property/method를 다시 정의.
// 오버로딩        overload. 같은 이름에 다른 parameter 형태를 제공.
// 확장           extension. 기존 타입에 기능 추가.
// 프로토콜 상속(개량)refinement. Combatant refines Movable.

// 프로토콜 준수가 중요하다.
protocol Movable {
    func move()
}
struct ExampleStruct1: Movable {    // 이걸 두고 'Struct adopts the Movable protocol' 또는
    func move() {}                  // 'Struct conforms to Movable'이라고 함. <- 이 쪽이 좀 더 선호되는 듯.
}

// protocol Movable은 move()의 존재를 요구(require)함.
// ExampleStruct1의 move()는 requirement에 대한 implementation.
// Struct가 Movable을 채택(comform)하다.
// Struct가 move()를 구현(implement)하다.

// 프로토콜은 다른 프로토콜을 상속(개량)할 수 있다.
protocol Combatant: Movable {
    func attack()
}
struct ExampleStruct2 : Combatant {
    func move() {}
    func attack() {}
}

//=============================================================================
// nil과 Optional
//=============================================================================
// Swift에서는 null이 아니라 nil이라고 한다.
// 그리고 Optional은 값이 없을 가능성이 있다고 표현할 때 사용.
// Optional은 타입 뒤에 ?를 붙여서 표현.
var optionalVariable: Int? = nil  // optionalVariable은 Integer 값을 담을 수 있는 변수이며, 값이 없을 수도 있다.

// Optional은 개념적으로 아래와 같다. enum의 각 요소가 어떻게 값을 갖는지에 대해선 추후 enum에 대해 설명할 때 다룬다.
//  enum Optional<Wrapped> {
//      case some(Wrapped)
//      case none
//  }

//=============================================================================
// 연산자
//=============================================================================
// 연산자는 C/C++, C# 등과 대부분 비슷함
// ++, -- 같은 연산자 없다!!!

// class 등의 객체에 한정하여 identity 동일성을 확인하는 ===가 있다.
class SomeClass {
    var contents = 0
}
let someClassA = SomeClass()
let someClassB = someClassA
print(someClassA === someClassB)  // true

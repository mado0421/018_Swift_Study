//
//  SwiftBasic.swift
//  SwiftStudy
//
//  Created by 신재욱 on 10/14/26.
//

/*
import Foundation

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
*/

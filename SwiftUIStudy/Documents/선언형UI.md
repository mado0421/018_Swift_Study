# 선언형 UI란
먼저 용어부터.

### Declarative[디클래러티브] 선언적인, 서술적인
무엇이 되어야 하는지를 기술하는 방식.

### Imperative[임페러티브] 명령적인, 명령형의
어떻게 수행해야 하는지를 명령하는 방식.

### 그래서?
명령형 UI는 상태의 변경과 갱신을 각각 지시해야 한다. 예를 들어 count 값의 증가와 UI의 count 값의 갱신 둘 다 프로그래머가 직접 지시해야 함.
선언형 UI는 상태의 변경만 지시하면 된다. count를 보게 해놓고 count 값을 증가시키면 알아서 count의 변경을 감지하고 자신이 보여주는 내용을 갱신한다.
짧게 요약하면 데이터의 변경과 화면의 변경 간 동기화 책임을 누가 갖고 있냐임. 내가 가지면 명령형, 프레임워크가 가지면 선언형.

```Swift
import SwiftUI

struct CounterView: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("Count: \(count)")
                .foregroundStyle(
                    count > 0 ? .green :
                    count < 0 ? .red : .gray
                )

            if count >= 10 {
                Text("Maximum reached!")
            }

            Button("Increase") {
                count += 1
            }
            .disabled(count >= 10)
        }
        .padding(30)
    }
}
```

# View as Value
SwiftUI의 View는 화면에 존재하는 UI 객체 자체가 아니라 UI를 기술하는 값(Value)이다.
SwiftUI에서는 UI 요소를 객체에 대한 참조가 아니라 값 타입으로 표현한다.

C#을 쓰는 WinForms에서는 Label 클래스의 인스턴스를 참조하여, 해당 객체의 속성을 변경한다. 기존 객체의 Text 프로퍼티를 수정하는 것이고 객체 자체는 계속 유지된다.
Swift에서도 기존 AppKit의 경우, NSTextField는 클래스고 해당 인스턴스의 프로퍼티를 변경한다.
SwiftUI에서 Text는 구조체다. 따라서 값 타입의 인스턴스다. 다른 변수에 대입하면 값 의미론에 따라 복사된다.
값을 생성하는 행위와 화면에 표시하는 행위는 구분된다.

### View는 실제 화면에 존재하는 객체인가?
아니다. SwiftUI의 View 값과 실제 화면을 구현하는 객체는 구분된다.
프로그래머가 작성한 SwiftUI 코드 -> View 값 생성 -> SwiftUI 프레임워크 -> 실제 UI 구성 및 화면 표시
SwiftUI의 View 값은 UI를 기술하는 데이터고, 실제 UI의 구현과 렌더링은 프레임워크가 담당함.

### 왜 이렇게 했을까? 무슨 장점 때문에?
값 타입의 장점은 다음과 같다.
1. UI 구성을 값으로 표현할 수 있다.
2. 데이터 흐름이 명확해짐.
3. 새로운 값으로 변경된 UI 구성을 표현할 수 있다. 기존 인스턴스를 수정하는 대신, 다른 프로퍼티 값을 가진 새로운 View 값을 사용할 수 있다.
4. SwiftUI가 변경 사항을 분석하고 필요한 UI를 갱신하는데 활용할 수 있다.

### View의 값은 계속 유지되는가?
SwiftUI의 View 값은 일시적일 수 있지만, 화면상의 View 정체성과 상태는 그보다 오래 유지될 수 있다.
SwiftUI는 View 값과 별개로 UI 요소의 Identity(정체성)를 관리.
View의 값 -> 변경되거나 새로 생성될 수 있음
View의 정체성 -> 여러 갱신에 걸쳐 유지될 수 있음
View의 상태 -> 정체성이 유지되는 동안 보존될 수 있음

### struct인데 @State가 어떻게 유지되는가?
@State를 쓰면 SwiftUI가 관리하는 상태 저장소와 연결. View 값이 새로 생성되더라도 같은 View 정체성이 유지된다면 기존 상태 저장소를 계속 사용할 수 있다.

### View Identity가 유지되는 기준은?
 SwiftUI에서 View Identity가 유지되는 기준은 SwiftUI가 이전에 존재하던 View와 현재 View를 동일한 View로 식별할 수 있는지 여부.
 1. Structural Identity(구조적 정체성): View 계층에서의 구조적 위치와 타입을 기반으로 식별.
 2. Explicit Identity(명시적 정체성): 프로그래머가 지정한 식별자(id)를 기반으로 식별.
 
#### Structural Identity
View 타입, 부모 View 내부에서의 구조적 위치, 동일한 조건 분기 등이 유지되면 같은 정체성으로 취급할 수 있다.

```Swift
if isEnabled {            
    CounterView(value: 10)        
} else {            
    CounterView(value: 20)        
}
```
위와 같이 작성할 경우 서로 다른 조건 분기에 선언된 View가 된다. 즉, 조건이 바뀌면 한 분기의 View가 제거되고 다른 분기의 View가 나타난다. -> 기존 CounterView의 정체성이 유지되지 않으며, @State가 초기화된다.
```Swift
CounterView(value: isEnabled ? 10 : 20)
```
위와 같이 작성하면 정체성을 유지하며, @State도 유지된다.

#### Explicit Identity
.id(_:) Modifier를 사용하여 정체성을 설정할 수 있다.
구조적 위치와 타입이 그대로여도 명시적 ID가 변경되면 새로운 정체성으로 취급되며, @State가 초기화된다.

#### 그 외에
다음과 같은 경우에 변경된다고 본다.
- if/else의 서로 다른 View 분기 사이 이동
- .id()에 전달하는 값 변경
- View가 계층에서 제거된 후 다시 추가

ForEach에서 데이터 ID를 유지한 채 순서를 변경하는 것은 유지된다.
동적 목록에서는 항목의 화면상 순서가 바뀌어도 안정적인 식별자가 있으면 같은 항목으로 추적할 수 있다. 구조적 위치가 항상 동일해야 할 필요는 없다.

### 정리하면
SwiftUI는 View 구조체의 메모리 주소를 정체성으로 사용하지 않는다. 구조체 값은 갱신 과정에서 새로 만들어질 수 있기 때문. 대신 Structural Identity, Explicit Identity를 활용하여 View의 수명을 관리한다. @State의 수명도 해당 정체성과 연결된다.

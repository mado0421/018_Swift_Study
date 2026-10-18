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

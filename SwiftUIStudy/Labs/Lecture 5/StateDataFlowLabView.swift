import Observation
//
//  StateDataFlowLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/31/26.
//
/*
 State Ownership(상태 소유권)
 어떤 View나 모델이 상태의 기준값을 관리하고 상태의 수명과 변경 책임을 맡는지.

 상태를 어디에 둘 것인가?
 한 View만 사용하는 독립 상태     -> 해당 View
 형제 View들이 공유하는 값       -> 공통 조상 View나 공유 모델
 여러 화면이 사용하는 도메인 데이터  -> 공유 모델
 자식이 표시만 하는 값           -> 원본 소유자가 전달하고 자식은 let
 자식이 원본을 편집하는 값        -> 원본 소유자가 Binding 전달
 State Hoisting(Hoist: ~를 위로 들어 올리다).

 Single Source of Truth를 지킬 것.
 해당 값이 새로운 사실을 보관하는지 아니면 이미 존재하는 사실을 다른 방식으로 표현하는지를 구분할 것.

 @State는 자신이 보관한 값의 변경을 관리. 자신이 보관한 값이라는 것이 중요함.
 struct + @State를 쓸 경우 struct의 내부 변수들의 변경까지 struct 그 자체의 변경으로 보기 때문에 @State에 보관된 구조체 값이 변경되고, SwiftUI가 그 상태의 변경을 감지하여 View 업데이트.
 class + @State를 쓸 경우 class 객체를 가리키는 변수가 @State가 보관하는 값이 되기 때문에 그 참조값이 변경되지 않는한 변경을 감지할 수가 없음.
 class + @State + @Observable을 쓰면 그 class 객체 내의 변수의 변경을 관찰할 수 있다.

 @Observable은 SwiftUI의 전용 기능이 아님.
 객체의 프로퍼티 변경을 감지하고 변경에 반응하는 코드를 실행하는데 사용 할 수 있음. 예를 들어 데이터 변경 시 로깅 등.

 @Observable
 final class Player {
     var hp = 100
     var mp = 50
 }

 let player = Player()

 withObservationTracking {          // 웃긴 점: 딱 한 번만 변경을 감지함.
     print("현재 HP: \(player.hp)")  //
 } onChange: {                      // 심지어 변경 후 최신 값을 반드시 읽는 콜백이라고 보장도 못함.
     print("HP 변경 감지")            // 변경이 발생했다 정도로 활용해야 함. 뭐야?
 }

 player.mp = 30
 player.hp = 80

 withObservationTracking은 정확히는 '이거 변경된 내용 있음'을 알릴 때 쓰기 좋다.
 예를 들어 변경이 없으면 가만히 있다가 변경이 생기면 한 번 다시 그리고 다시 가만히 있기 정도.
 현재 결과물이 오래되었다고 표시하고 이후 시점에 새 결과를 만드는 것 -> Invalidation(무효화)?
 그리고 이건 일회성 관찰이기 때문에 재등록 절차 같은걸 만들어줘야 함.
 또는 Swift 6.2에 추가된 Observations를 쓴다. 이건 비동기 관찰 유지임.
 일단 SwiftUI에서는 @Observable을 쓴다는 것만 이해하면 될 듯.
 */
/*
 Environment / 직접 전달과 Environment 전달
 여러 계층으로 된 View 계층이 있을때 최상위 View에서 최하위 View로 모델을 전달하기 위해 그 모델을 사용하지 않는 중간 계층 View도 모델을 받아서 전달을 해야 한다. 이런걸 Prop Drilling(프롭 드릴링), Parameter Drilling라고 한다 함.
 Environment를 사용하면 Root에서 한 번 주입하고 실제 사용하는 View에서 읽어서 사용한다.
 여러 계층에 걸친 공통 의존성이 있을 때 Environment 사용을 고려하면 됨.
 
 그리고 솔직히 필요한 의존성이 무엇이 있는지 등을 알기 어려운 것이 사용하기에 좀 꺼려지는 부분인 듯.
 컬러 스킴이나 로케일 같은 시스템 환경, View 계층의 공통 동작, 외형 설정 같은걸 하기엔 좋을거 같음.
 @Environment(\.colorScheme)
 @Environment(\.locale)
 @Environment(\.dismiss) <- 이런거 다 뭔가 있다고 함.
 @Environment(\.openURL)
 이런 것들.
 
 여러 창이나 문서에서 서로 다른 모델을 사용할 때는 좋음. 여러 문서를 동시에 열 수 있는 앱이라면 각 창은 서로 다른 문서 모델을 사용 가능.
 앱 전체에 하나의 모델을 주입하는 것이 아니라 각 창이나 문서의 루트 view에 해당 모델을 주입.
 
 어쨌든 여러 하위 View가 막 퍼져 있는데 하나의 공통된 무언가를 써야 한다면 Environment를 사용한다. 
 */
import SwiftUI

@Observable
private final class ProfileModel {
    var name: String
    var volume: Double

    init(name: String, volume: Double) {
        self.name = name
        self.volume = volume
    }
}

@Observable
private final class CharacterModel {
    var name: String

    init(name: String) {
        self.name = name
    }
}

struct StateDataFlowLabView: View {
    @State private var profileModel = ProfileModel(name: "Jung", volume: 50.0)
    @State private var characterModel = CharacterModel(name: "Shin")

    var body: some View {
        VStack(spacing: 20) {
            ObservationNameView(model: profileModel)
            ObservationVolumeView(model: profileModel)

            Divider()
            Button("Change Name") {
                profileModel.name =
                    profileModel.name == "Jung" ? "Shin" : "Jung"
            }
            Button("Increase Volume") {
                profileModel.volume += 10
            }
            Divider()
            VStack {
                EnvrionmentNameView()
                EnvrionmentEditorView()
            }
            .environment(characterModel)
        }
        .padding()
    }
}

private struct ObservationNameView: View {
    @Bindable var model: ProfileModel

    var body: some View {
        let _ = Self._printChanges()

        TextField("Name", text: $model.name)
    }
}
private struct ObservationVolumeView: View {
    let model: ProfileModel

    var body: some View {
        let _ = Self._printChanges()

        Text("Volume: \(model.volume)")
    }
}

private struct EnvrionmentNameView: View {
    @Environment(CharacterModel.self) private var model: CharacterModel?

    var body: some View {
        Text("EnvironmentName: \(model?.name ?? "Default Model")")
    }
}
private struct EnvrionmentEditorView: View {
    @Environment(CharacterModel.self) private var model: CharacterModel?

    var body: some View {
        //        @Bindable var editableModel = model ?? CharacterModel(name: "Default Model")

        VStack {
            TextField(
                "Name",
                text: Bindable(model ?? CharacterModel(name: "Default Model"))  // 이렇게 써도 된다.
                    .name
            )

            Button("Reset") {
                model?.name = "Alice"
            }
        }
    }
}

#Preview {
    StateDataFlowLabView()
}

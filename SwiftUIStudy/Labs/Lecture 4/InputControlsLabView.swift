//
//  InputControlsLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/28/26.
//

import SwiftUI

struct InputControlsLabView: View {
    var body: some View {
        ScrollView {
            focusExample
            buttons
            textFields
            textEditors
            toggles
            pickers
            sliders
        }
        .padding()
        .frame(width: 800)
    }

    enum Field: Hashable {
        case name
        case email
        case phone
    }
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @FocusState private var focusedField: Field?    // 선택지 중에 포커싱 중인게 없을 수도 있음. 그런 경우엔 nil.
    private var focusExample: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Focus Example")
                .font(.title)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
            VStack(alignment: .leading) {
                TextField("Name", text: $name)
                    .focused($focusedField, equals: .name)
                    .onSubmit {
                        focusedField = .email
                    }
                TextField("Email", text: $email)
                    // View와 포커스 식별값을 대응시키는 역할
                    // Email TextField와 .email 식별값 연결
                    .focused($focusedField, equals: .email)
                    .onSubmit {
                        if name.isEmpty {
                            focusedField = .name
                        } else {
                            focusedField = .phone
                        }
                    }
                TextField("Phone", text: $phone)
                    .focused($focusedField, equals: .phone)
                    .onSubmit {
                        focusedField = nil
                    }
                Text("Focus: \(String(describing: focusedField))")

                HStack {
                    Button("Focus Name") {
                        focusedField = .name
                    }

                    Button("Focus Email") {
                        focusedField = .email
                    }

                    Button("Remove Focus") {
                        focusedField = nil
                    }
                }
            }
            .padding(4)
        }
    }

    /*
     @State는 SwiftUI가 View의 생명주기와 연결하여 관리하는 상태 선언.
     저장 프로퍼티에 사용. wrappedValue는 Value, projectedValue는 Binding<Value>
     */
    @State private var count: Int = 0
    private var buttons: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Button")
                .font(.title)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
            HStack {
                Button("Increase") {
                    count += 1
                }
                .buttonStyle(.borderedProminent)

                Button("Reset", role: .destructive) {
                    count = 0
                }
                .disabled(count == 0)
            }
            HStack {
                Button("Confirm", role: .confirm) {}
                Button("Close", role: .close) {}
                Button("Cancel", role: .cancel) {}
                Button("Destructive", role: .destructive) {}
            }
            HStack {
                Button(".bordered") {}
                    .buttonStyle(.bordered)
                Button(".prominent") {}
                    .buttonStyle(.borderedProminent)
                Button(".plain") {}
                    .buttonStyle(.plain)
                Button(".disabled") {}
                    .disabled(true)
            }
            HStack {
                Button(".bordered") {}
                    .buttonStyle(.bordered)
                Button(".prominent") {}
                    .buttonStyle(.borderedProminent)
                Button(".plain") {}
                    .buttonStyle(.plain)
                Button(".disabled") {}
                    .disabled(true)
            }
            .disabled(true)
        }
    }

    @State private var volume = 0.0
    @State private var isEditingVolume = false
    private var sliders: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Slider")
                .font(.title)
                .fontWeight(.semibold)
                .fontDesign(.rounded)

            HStack {
                Text("Volume is \(volume, specifier: "%.1f")")
                Toggle("is Editing now", isOn: $isEditingVolume)
                    .disabled(true)
            }
            VStack(spacing: 12) {
                Slider(value: $volume, in: -20...20) { editing in
                    isEditingVolume = editing
                }
                Slider(
                    value: $volume,
                    in: -20...20,
                    step: 5,
                    label: { Text("Slider Label") },
                    minimumValueLabel: { Text("min label") },
                    maximumValueLabel: { Text("max label") }
                ) {
                    editing in
                    isEditingVolume = editing
                }
            }
        }
    }

    /*
     TextField axis: .vertical과 TextEditor
     둘 다 여러 줄을 편집할 수 있는데 주로 사용하는 용도가 다름
     TextField + .vertical은 짧은 다중 행 입력 용도고,
     TextEditor는 긴 문서형 텍스트 입력 용도임.
     높이도 TextField는 내용에 따라 확장되는데 TextEditor는 프레임 내로 한정.

     Binding<Value>는 특정 값에 대한 읽기와 쓰기 접근을 제공.
     Binding은 원본 데이터에 접근하는 인터페이스로 생각하면 됨.

     $를 프로퍼티 이름 앞에 붙이면 Binding<Value>를 가져올 수 있다.
     그 프로퍼티가 제공하는 projectedValue에 접근.

     @Binding은 다른 곳에서 관리하는 상태를 Binding으로 전달받는 프로퍼티를 선언.
     @Binding은 자체적으로 상태의 원본 저장소를 소유하지 않음.
     Binding.contant(_:)하면 읽기만 되고 변경은 안되는 상수 Binding을 만듦.

     Binding이 왜 필요한데? -> 컨트롤과 상태 저장소를 서로 연결해야 하기 때문.
     예를 들어 TextField는 사용자가 글자를 입력할 때마다 원본 문자열을 변경해야 하고,
     그러면서 동시에 그 문자열의 현재 값도 알아야 함. 즉, 읽기도 하고 변경되면 저장도 할 수 있어야 함.
     이렇게 읽기랑 쓰기 연결을 제공하는게 Binding임.

     @Binding은 왜 필요한데?
     struct NameEditor: View {
         @Binding var name: String <- 요렇게 받아야 부모 View한테서 Binding을 받을 수 있음.
     }
     */
    @State private var textFieldName = ""
    @State private var submittedName = ""
    private var textFields: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("TextField")
                .font(.title)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
            HStack {
                TextField("수평 확장", text: $textFieldName)
                    .onSubmit {
                        // do something
                    }
                    .padding(4)
                TextField(
                    "",
                    text: $textFieldName,
                    prompt: Text("프롬프트"),
                    axis: .vertical
                )
                .lineLimit(1...4)
                .padding(4)
                TextField("수직 확장", text: .constant("Fixed"), axis: .vertical)
                    .lineLimit(2...4)
                    .padding(4)
            }
            .textFieldStyle(.plain)
            .onSubmit {
                submittedName = textFieldName.trimmingCharacters(
                    in: .whitespacesAndNewlines
                )
            }
            HStack {
                Text("Submitted name is \(submittedName).")
                Button("Reset") {
                    textFieldName = ""
                }
            }
        }
    }

    @State private var note = ""
    private var textEditors: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("TextEditor")
                .font(.title)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
            HStack(spacing: 12) {
                TextEditor(text: $note)
                    .scrollContentBackground(.hidden)  // <- 이거 해줘야 배경이 보임
                // 스크롤 컨텐츠의 배경이 background를 가리기 때문
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.mint.opacity(0.2))
            }
            .frame(height: 140)
        }
    }

    @State private var notificationsEnabled = false
    private var toggles: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Toggle")
                .font(.title)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
            HStack {
                Toggle("버튼 사용", isOn: $notificationsEnabled)
                    .toggleStyle(.switch)
                Toggle(isOn: $notificationsEnabled) {
                    Label("Notifications", systemImage: "bell")
                }
                .toggleStyle(.checkbox)
                Toggle("사용", isOn: $notificationsEnabled)
                    .toggleStyle(.button)
            }
            HStack {
                Button("something") {

                }.disabled(!notificationsEnabled)
            }
        }
    }

    private enum ItemSize: String, CaseIterable, Hashable {
        case small = "Small"
        case medium = "Medium"
        case large = "Large"
    }
    @State private var selected: Int = 0
    @State private var selectedSize: ItemSize = ItemSize.small
    private var pickers: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Picker")
                .font(.title)
                .fontWeight(.semibold)
                .fontDesign(.rounded)

            HStack(spacing: 12) {
                Picker("Case", selection: $selected) {
                    Text("A").tag(0)
                    Text("B").tag(1)
                    Text("C").tag(2)
                }

                Text("Selected is \(selected).")
            }
            /*
             몇 개의 짧은 후보를 항상 표시하고 싶다면 .segmented.
             개별 선택지를 라디오 버튼으로 명확하게 보여주고 싶다면 .radioGroup.
             많은 후보를 제한된 공간에서 선택하려면 .menu.
             아이콘이나 도구처럼 컴팩트한 항목 선택을 표현하려면 .palette.
             컨테이너에 따라 자동 배치를 활용하려면 .inline.
             */
            HStack(spacing: 12) {
                Picker(".menu", selection: $selectedSize) {
                    ForEach(ItemSize.allCases, id: \.self) { size in
                        Text(size.rawValue)
                            .tag(size)
                    }
                }
                .pickerStyle(.menu)

                // 현재 컨테이너 내부에 선택지를 직접 배치
                Picker(".inline", selection: $selectedSize) {
                    ForEach(ItemSize.allCases, id: \.self) { size in
                        Text(size.rawValue)
                            .tag(size)
                    }
                }
                .pickerStyle(.inline)

                // 도구, 색상, 아이콘 등 시각적인 선택지를 나타내는 용도
                Picker(".palette", selection: $selectedSize) {
                    ForEach(ItemSize.allCases, id: \.self) { size in
                        Text(size.rawValue)
                            .tag(size)
                    }
                }
                .pickerStyle(.palette)
            }
            HStack(spacing: 12) {
                // 라디오 버튼 형태로 선택지를 표시
                Picker(".radioGroup", selection: $selectedSize) {
                    ForEach(ItemSize.allCases, id: \.self) { size in
                        Text(size.rawValue)
                            .tag(size)
                    }
                }
                .pickerStyle(.radioGroup)
                Picker(".tabs", selection: $selectedSize) {
                    ForEach(ItemSize.allCases, id: \.self) { size in
                        Text(size.rawValue)
                            .tag(size)
                    }
                }
                .pickerStyle(.tabs)

                // 여러 선택값을 하나의 분할 컨트롤로 표시
                Picker(".segmented", selection: $selectedSize) {
                    ForEach(ItemSize.allCases, id: \.self) { size in
                        Text(size.rawValue)
                            .tag(size)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
    }
}

#Preview {
    InputControlsLabView()
}

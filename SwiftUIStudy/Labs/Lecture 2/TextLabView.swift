import SwiftUI

struct InnerTextEditView : View {
    // 구조체라서 생성자가 init(message:)와 같이 자동 생성됨
    @Binding var message: String
    @State private var draft = ""
    
    var body: some View {
        HStack(alignment: .center) {
            Text("자식뷰의 편집 영역")
                .font(.headline)
            TextEditor(text: $draft)
                .frame(minWidth: 140.0, minHeight: 80.0)
            VStack {
                Button("적용") {
                    message = draft
                }
                Button("부모 값 가져오기") {
                    draft = message
                }
            }
        }
        .buttonStyle(.borderless)
        .buttonSizing(.flexible)
        .padding()
        .background(.blue)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
        // 처음 나타날 때 한 번만.
        .onAppear {
            draft = message
        }
    }
}

struct TextLabView: View {
    @State private var message = "SwiftUI Lab"
    private let stringArray = ["Hello", "World"]
    private let from = "A", to = "B"

    var body: some View {
        ScrollView {
            
            
            VStack(alignment: .leading) {
                // literal string을 넣을 경우 LocalizedStringKey로 해석함.
                // 해당하는 번역 리소스가 없을 경우 키 자체가 표시됨.
                // 이 때는 인라인 markdown도 해석함.
                Text("**굵게**")
                Text("Cancel", tableName: "LocalizableText")
                Text("Hello, \(message).", tableName: "LocalizableText")
                Text("\(from) to \(to).", tableName: "LocalizableText")
                Text(message)
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                    .foregroundStyle(Gradient(colors: [.white, .blue, .green]))
                    .shadow(radius: 1, x: 1, y: 3)
                Spacer()
                // String 값을 넣을 경우 문자열 값을 현지화 없이 표시함.
                Text(message)
                
                // FormatStyle
                // https://developer.apple.com/documentation/foundation/formatstyle
                Text(10, format: .number)
                Text(10, format: .percent)
                Text(10, format: .currency(code: "KRW"))
                
                Spacer()
                Text(Date(), format: .dateTime)
                Text(Date(), format: .iso8601)
                
                let dateStart = Date.now
                let dateEnd = dateStart.addingTimeInterval(36000)
                Text(dateStart..<dateEnd, format: .interval)
                Text(Date().addingTimeInterval(-3600), format: .relative(presentation: .named))
                
                Text(stringArray, format: .list(type: .or))
                Spacer()
                Text(Measurement(value: 1500.0, unit: UnitLength.meters), format: .measurement(width: .wide))
                
                TextField("Message", text: $message)
                TextEditor(text: $message)
                    .multilineTextAlignment(.center)
                InnerTextEditView(message: $message)
            }
            .padding()
        }
    }
}

#Preview("Text — 생성자 비교") {
    TextLabView()
        .environment(\.locale, Locale(identifier: "ko"))
}

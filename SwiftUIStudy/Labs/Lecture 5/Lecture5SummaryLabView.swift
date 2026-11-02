//
//  Lecture5SummaryLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/31/26.
//

import SwiftUI

private enum Lecture5Theme: String, CaseIterable, Identifiable {
    case system, light, dark
    var id: Self { self }
}
private struct ProfileSettings: Equatable {
    var name: String = "Alice"
    var theme: Lecture5Theme = .system
    var notificationsEnabled: Bool = true
    var volume: Double = 50

    var isNameInvalid: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
@Observable
private class Lecture5User {
    var savedSettings: ProfileSettings
    var editingSettings: ProfileSettings

    init(savedSettings: ProfileSettings = ProfileSettings()) {
        self.savedSettings = savedSettings
        self.editingSettings = savedSettings
    }

    func save() {
        guard isChanged && !isNameInvalid else { return }

        editingSettings.name = editingSettings.name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        savedSettings = editingSettings
    }
    func cancel() {
        editingSettings = savedSettings
    }
    func setDefaultToEdit() {
        editingSettings = ProfileSettings()
    }

    var isChanged: Bool { savedSettings != editingSettings }
    var isNameInvalid: Bool { editingSettings.isNameInvalid }
}
private nonisolated struct Line: Shape {
    var t: CGFloat

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(
                to: CGPoint(x: 0, y: rect.midY)
            )
            path.addLine(
                to: CGPoint(
                    x: rect.width * t,
                    y: rect.midY
                )
            )
        }
    }
}
private nonisolated var myGradient: some ShapeStyle {
    LinearGradient(
        colors: [.mint, .cyan, .blue, .indigo],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

struct Lecture5SummaryLabView: View {
    @State private var userData: Lecture5User = Lecture5User()
    @FocusState private var isNameFocused

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                header
                ViewThatFits {
                    HStack {
                        ProfileDisplayView(
                            title: "Last Saved",
                            profileSettings: userData.savedSettings
                        )
                        ProfileDisplayView(
                            title: "Preview",
                            profileSettings: userData.editingSettings
                        )
                    }
                    VStack {
                        ProfileDisplayView(
                            title: "Last Saved",
                            profileSettings: userData.savedSettings
                        )
                        ProfileDisplayView(
                            title: "Preview",
                            profileSettings: userData.editingSettings
                        )
                    }
                }

                EditorView(
                    settings: $userData.editingSettings,
                    isNameFocused: $isNameFocused
                )
                controlPanel
            }
            .padding()
        }
    }

    private var header: some View {
        VStack(alignment: .leading) {
            Text("Profile Studio(5강 종합 실습)")
                .foregroundStyle(myGradient)
                .font(.title)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
            Text(
                "Customize your profile and preferences(@State, @Binding, @Observable, @Bindable...)"
            )
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var controlPanel: some View {
        HStack {
            Text(
                "\(userData.isChanged ? "Unsaved changes." : "All changes saved.")"
            )
            .foregroundStyle(.secondary)
            .font(.caption)
            Spacer()
            Button("Save") {
                if userData.isNameInvalid {
                    isNameFocused = true
                } else {
                    userData.save()
                }
            }
            .disabled(!userData.isChanged)
            .buttonStyle(.borderedProminent)
            Button("Cancel") {
                userData.cancel()
            }
            .disabled(!userData.isChanged)
            Button("Reset to Defaults") {
                userData.setDefaultToEdit()
            }
        }
        .frame(maxWidth: .infinity)
    }
}

private struct ProfileDisplayView: View {
    private let title: String
    private let profileSettings: ProfileSettings

    init(title: String, profileSettings: ProfileSettings) {
        self.title = title
        self.profileSettings = profileSettings
    }

    var body: some View {
        VStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title3)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
            Image("LabPhoto")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            Text("\(profileSettings.name.isEmpty ? " " : profileSettings.name)")
                .lineLimit(1, reservesSpace: true)
                .font(.title)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
            Text(
                "\(profileSettings.theme.rawValue) / \(String(profileSettings.notificationsEnabled))"
            )
            .foregroundStyle(.secondary)

            volumeSlider
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .shadow(
                    color: .brown.opacity(0.5),
                    radius: 2,
                    y: 2
                )
        )
    }

    private var volumeSlider: some View {
        HStack {
            Text("Volume: \(profileSettings.volume, specifier: "%.0f")%")
                .frame(width: 100, alignment: .leading)
            ZStack {
                Line(t: 1)
                    .stroke(
                        .secondary,
                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                    )
                Line(t: profileSettings.volume * 0.01)
                    .stroke(
                        myGradient,
                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                    )
            }
        }
        .frame(maxWidth: .infinity)
    }
}

private struct EditorView: View {
    @Binding private var settings: ProfileSettings
    @FocusState.Binding private var isNameFocused: Bool

    // 부모의 원본 상태와 연결을 유지하려면 일반 값 대신 Binding을 받아야 함.
    // settings과 isNameFocused는 각 래퍼의 wrappedValue, 즉 연결을 통해 읽고 쓰는 값.
    // _settings과 _isNameFocused는 Swift가 자동 생성한 프로퍼티 래퍼 저장소.
    // 초기화 시 이 저장소에 전달받은 Binding 자체를 넣어 부모 상태와 연결.
    init(
        settings: Binding<ProfileSettings>,
        isNameFocused: FocusState<Bool>.Binding
    ) {
        self._settings = settings
        self._isNameFocused = isNameFocused
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Edit Profile")
                .font(.title2)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
            TextField(
                "Name",
                text: $settings.name,
                prompt: Text("input name")
            )
            .focused($isNameFocused)
            Text("Please enter a valid name.")
                .foregroundStyle(.red.opacity(settings.isNameInvalid ? 1 : 0))
                .font(.caption)
                .lineLimit(1, reservesSpace: true)
            Picker("Theme", selection: $settings.theme) {
                ForEach(Lecture5Theme.allCases) { theme in
                    Text(theme.rawValue).tag(theme)
                }
            }
            Toggle(
                "NotificationsEnabled",
                isOn: $settings.notificationsEnabled
            )
            Slider(
                value: $settings.volume,
                in: 0...100,
                step: 5,
                label: { Text("Volume") },
                minimumValueLabel: { Text("0") },
                maximumValueLabel: { Text("100") }
            )
            .disabled(!settings.notificationsEnabled)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    Lecture5SummaryLabView()
}

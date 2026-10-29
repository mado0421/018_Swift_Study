//
//  Lecture4SummaryLabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/28/26.
//

import SwiftUI

struct Lecture4SummaryLabView: View {
    private enum Lecture4Theme: String, CaseIterable, Hashable {
        case system = "System"
        case light = "Light"
        case dark = "Dark"
    }
    private struct Lecture4State {
        var profileName: String
        var description: String
        var isNotificationsEnabled: Bool
        var currentTheme: Lecture4Theme
        var volumePercentage: Double
    }
    static private let initialState = Lecture4State(
        profileName: "",
        description: "",
        isNotificationsEnabled: true,
        currentTheme: .system,
        volumePercentage: 50.0
    )
    @State private var currentState = initialState
    @State private var editingState = initialState
    @FocusState private var isProfileNameAreaFocused

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Preferences Editor")
                    .font(.title)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                typeProfileNameArea
                typeDescriptionArea
                checkNotificationEnabledArea
                selectThemeArea
                setNotificationVolumeArea
                saveAndResetButtons
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
            VStack(alignment: .leading, spacing: 12) {
                Text("Current State")
                    .font(.title)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                VStack(alignment: .leading) {
                    Text("Profile Name")
                        .font(.caption)
                    Text(currentState.profileName)
                }
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.caption)
                    Text(currentState.description)
                }
                Text(
                    "Notifications are \(currentState.isNotificationsEnabled ? "enabled" : "disabled")."
                )
                Text("Theme is \(currentState.currentTheme.rawValue).")
                Text(
                    "Volume percentage is \(currentState.volumePercentage, specifier: "%.0f")%"
                )
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
        }
        .padding()
    }

    private var typeProfileNameArea: some View {
        VStack(alignment: .leading) {
            Text("Profile Name")
                .font(.body)
            TextField(
                "ProfileNameField",
                text: $editingState.profileName,
                prompt: Text("Enter profile name")
            )
            .focused($isProfileNameAreaFocused)
        }
        .padding(.vertical, 4)
    }
    private var typeDescriptionArea: some View {
        VStack(alignment: .leading) {
            Text("Description")
                .font(.body)
            TextEditor(text: $editingState.description)
                .scrollContentBackground(.hidden)
                .padding(4)
                .frame(height: 40)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.gray.opacity(0.2))
                }
        }
        .padding(.vertical, 4)
    }
    private var checkNotificationEnabledArea: some View {
        HStack {
            Toggle(
                "Enable Notifications",
                isOn: $editingState.isNotificationsEnabled
            )
        }
        .padding(.vertical, 4)
    }
    private var selectThemeArea: some View {
        VStack(alignment: .leading) {
            Picker(
                "Theme",
                selection: $editingState.currentTheme
            ) {
                ForEach(Lecture4Theme.allCases, id: \.self) { theme in
                    Text(theme.rawValue).tag(theme)
                }
            }
        }
        .padding(.vertical, 4)
    }
    private var setNotificationVolumeArea: some View {
        VStack(alignment: .leading) {
            Text(
                "Notification Volume \(editingState.volumePercentage, specifier: "%.0f")%"
            )
            .font(.body)
            Slider(value: $editingState.volumePercentage, in: 0...100, step: 5)
        }
        .disabled(!editingState.isNotificationsEnabled)
        .padding(.vertical, 4)
    }
    private var saveAndResetButtons: some View {
        HStack {
            Button("Reset") {
                editingState = Lecture4SummaryLabView.initialState
            }
            Button("Save") {
                let trimmedName = editingState.profileName.trimmingCharacters(
                    in: .whitespacesAndNewlines
                )

                if trimmedName.isEmpty {
                    isProfileNameAreaFocused = true
                } else {
                    currentState = editingState
                    currentState.profileName = trimmedName
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview {
    Lecture4SummaryLabView()
}

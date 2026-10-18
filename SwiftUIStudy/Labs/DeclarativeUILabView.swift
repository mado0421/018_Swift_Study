//
//  DeclarativeUILabView.swift
//  SwiftUIStudy
//
//  Created by 신재욱 on 10/18/26.
//

import SwiftUI

struct DeclarativeUILabView: View {
    @State private var count = 0
    
    var body: some View {
        VStack(spacing: 20){
            Text("Declarative UI Lab")
                .font(.title)
            Text("Count: \(count)")
                .font(.largeTitle)
                .foregroundStyle(
                    count > 0 ? .green : count < 0 ? .red : .gray
                )
            HStack(spacing: 12) {

                 Button("Decrease") {
                     count -= 1
                 }

                 Button("Reset") {
                     count = 0
                 }

                 Button("Increase") {
                     count += 1
                 }
             }
            
            if count == 0 {
                Text("Zero")
            } else if count > 0 {
                Text("Positive")
            } else {
                Text("Negative")
            }
        }
        .padding(30)
        .frame(minWidth: 400, minHeight: 250)
    }
}

#Preview {
    DeclarativeUILabView()
}

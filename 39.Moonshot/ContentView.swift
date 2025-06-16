//
//  ContentView.swift
//  39.Moonshot
//
//  Created by Валентин on 16.06.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { row in
                NavigationLink ("Row \(row)") {
                    Text("Detail \(row)")
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

#Preview {
    ContentView()
}

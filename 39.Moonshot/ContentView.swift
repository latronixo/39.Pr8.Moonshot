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
            NavigationLink("Tap me"){
                Text("Detail View")
            }
            .navigationTitle("SwiftUI")
        }
    }
}

#Preview {
    ContentView()
}

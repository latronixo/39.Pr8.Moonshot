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
            NavigationLink {
                Text("Detail View")
            } label: {
                VStack{
                    Text("Это текстовая метка")
                    Text("да, это она")
                    Image(systemName: "face.smiling")
                }
                .font(.largeTitle)
            }
            .navigationTitle("SwiftUI")
        }
    }
}

#Preview {
    ContentView()
}

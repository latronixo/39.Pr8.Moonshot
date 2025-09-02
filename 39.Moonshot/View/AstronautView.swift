//
//  AstronautView.swift
//  39.Moonshot
//
//  Created by Валентин on 19.06.2025.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .accessibilityLabel("Фотография \(astronaut.name)")
                
                Text(astronaut.description)
                    .padding()
                    .accessibilityLabel("Об астронавте и его роли в миссии: \(astronaut.description)")
            }
            .accessibilityElement(children: .combine)
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("") {}
                    .accessibilityLabel("Скажите назад для возврата к списку экипажа")
                    .accessibilityInputLabels(["назад", "к списку экипажа"])
            }
        }
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return AstronautView(astronaut: astronauts["aldrin"]!)
        .preferredColorScheme(.dark)
}

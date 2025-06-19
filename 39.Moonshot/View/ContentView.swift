//
//  ContentView.swift
//  39.Moonshot
//
//  Created by Валентин on 16.06.2025.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var showInGrid = true
    
    var body: some View {
        NavigationStack {
            Group {
                if showInGrid {
                    gridView
                } else {
                    listView
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .toolbar {
                Button {
                    showInGrid.toggle()
                } label: {
                    Image(systemName: showInGrid ? "rectangle.grid.1x2" : "rectangle.grid.2x2")
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                missionCards
            }
            .padding([.horizontal, .bottom])
        }
    }
    
    private var listView: some View {
        List {
            missionCards
        }
        .listStyle(.plain)
        .listRowBackground(Color.darkBackground)
    }
    
    private var missionCards: some View {
        ForEach(missions) { mission in
            NavigationLink {
                MissionView(mission: mission, astronauts: astronauts)
            } label: {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                    
                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                }
                .clipShape(.rect(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(.lightBackground)
                )
            }
            .listRowBackground(Color.darkBackground)
        }
    }
}

#Preview {
    ContentView()
}

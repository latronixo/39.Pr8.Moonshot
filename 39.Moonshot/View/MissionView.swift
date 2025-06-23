//
//  MissionView.swift
//  39.Moonshot
//
//  Created by Валентин on 18.06.2025.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember: Hashable {
        let role: String
        let astronaut: Astronaut
    }

    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView {
            VStack {
                // Основная информация о миссии
                missionHeader
                missionDetails
                
                // Кнопка для перехода к списку экипажа
                NavigationLink(value: crew){
                    HStack {
                        Text("See Crew")
                            .font(.headline)
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
        .navigationDestination(for: [CrewMember].self) { crew in
            CrewListView(crew: crew)
        }
    }
    
    // MARK: - Subviews
    
    private var missionHeader: some View {
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { width, _ in
                    width * 0.6
                }
            
            if let dateLaunch = mission.launchDate {
                Text("Date launched: \(dateLaunch.formatted(date: .abbreviated, time: .omitted))")
            } else {
                Text("Не была выполнена")
            }
        }
    }
    
    private var missionDetails: some View {
        VStack(alignment: .leading) {
            divider
            
            Text("Mission Highlights")
                .font(.title.bold())
                .padding(.bottom, 5)
            
            Text(mission.description)
            
            divider
        }
        .padding(.horizontal)
    }
    
    private var divider: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.compactMap { member in
            astronauts[member.name].map { astronaut in
                CrewMember(role: member.role, astronaut: astronaut)
            }
        }
    }
}

// MARK: - Crew List View
struct CrewListView: View {
    let crew: [MissionView.CrewMember]
    
    var body: some View {
        List(crew, id: \.role) { member in
            NavigationLink(value: member) {
               HStack {
                    Image(member.astronaut.id)
                        .resizable()
                        .frame(width: 133, height: 100  )
                        .clipShape(.capsule)
                        .overlay(
                            Capsule()
                                .strokeBorder(.white, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(member.astronaut.name)
                            .font(.headline)
                        Text(member.role)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .listRowBackground(Color.darkBackground)
        }
        .navigationTitle("Mission Crew")
        .background(.darkBackground)
        .scrollContentBackground(.hidden)
        .navigationDestination(for: MissionView.CrewMember.self) { crewMember in
            AstronautView(astronaut: crewMember.astronaut)
        }
    }
}

// MARK: - Crew Member View
struct CrewMemberView: View {
    let crewMember: MissionView.CrewMember
    
    var body: some View {
        HStack {
            Image(crewMember.astronaut.id)
                .resizable()
                .frame(width: 120, height: 83)
                .clipShape(.capsule)
                .overlay(
                    Capsule()
                        .strokeBorder(.white, lineWidth: 1)
                )
            
            VStack(alignment: .leading) {
                Text(crewMember.astronaut.name)
                    .foregroundStyle(.white)
                    .font(.headline)
                Text(crewMember.role)
                    .foregroundStyle(.white.opacity(0.5))
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return NavigationStack {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
    .preferredColorScheme(.dark)
}

//
//  MissionView.swift
//  Moonshot
//
//  Created by Michael Pedigo on 11/11/2025.
//

import SwiftUI


struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]


    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission


        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing astronaut: \(member.name)")
            }
        }
    }


    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .padding(.top)


                Text(mission.formattedLaunchDate)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)


                VStack(alignment: .leading, spacing: 10) {
                    Text("Mission Highlights")
                        .font(.title.bold())


                    Text(mission.description)


                    Text("Crew")
                        .font(.title.bold())
                        .padding(.top)


                    ForEach(crew, id: \.role) { crewMember in
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 80, height: 60)
                                .clipShape(.rect(cornerRadius: 10))


                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundStyle(.secondary)
                            }


                            Spacer()
                        }
                        .padding(.vertical, 4)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

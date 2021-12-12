//
//  SeasonsView.swift
//  BreakingBadApp
//
//  Created by Kuba Milcarz on 10/12/2021.
//

import SwiftUI

struct SeasonsView: View {
    @ObservedObject var dataStore: DataStore
    
    var body: some View {
        NavigationView {
            List(dataStore.episodes, id: \.episode_id) { episode in
                Text(episode.title)
            }
            .task {
                await loadData()
            }
            .navigationTitle("Episodes")
        }
    }
    
    func loadData() async {
        guard dataStore.episodes.isEmpty else { return }
        
        do {
            let url = URL(string: "https://www.breakingbadapi.com/api/episodes/")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            print("hello 1")
            let episodes = try decoder.decode([Episode].self, from: data)
            print("hello 2")
            await MainActor.run {
                dataStore.fetchEpisodes(with: episodes)
                print("hello 3")
            }
            print("hello 4")
        } catch {
            print("Downloading data failed.")
        }
    }
}

struct SeasonsView_Previews: PreviewProvider {
    static var previews: some View {
        SeasonsView(dataStore: DataStore())
    }
}

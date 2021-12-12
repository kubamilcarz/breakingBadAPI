//
//  ContentView.swift
//  BreakingBadApp
//
//  Created by Kuba Milcarz on 10/12/2021.
//

import SwiftUI

struct CharactersView: View {
    @ObservedObject var dataStore: DataStore
    
    @State private var query = ""
    @State private var dataLoaded = false
    
    var body: some View {
        NavigationView {
            SearchableList(dataStore: dataStore, characters: dataStore.filteredCharacters)
            .task {
                await loadData()
            }
            
            .navigationTitle("Characters")
        }
        .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search characters")
        .onChange(of: query) { query in
            if !query.isEmpty {
                dataStore.filteredCharacters = dataStore.filteredCharacters.filter { $0.name.contains(query) }
            } else {
                dataStore.filteredCharacters = dataStore.characters
            }
        }
    }
    
    func loadData() async {
        guard dataStore.characters.isEmpty else { return }
        
        do {
            let url = URL(string: "https://www.breakingbadapi.com/api/characters/")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let characters = try decoder.decode([Character].self, from: data)
            await MainActor.run {
                dataStore.fetchCharacters(with: characters)
                dataLoaded = true
            }
        } catch {
            print("Downloading data failed.")
        }
    }
}

struct SearchableList: View {
    @Environment(\.isSearching) private var isSearching: Bool
    
    var dataStore: DataStore
    var characters: [Character]
    
    var body: some View {
        List(characters, id: \.char_id) { character in
            NavigationLink {
                CharacterDetailView(character: character)
            } label: {
                CharacterRow(character: character)
            }
        }
        .onChange(of: isSearching) { newValue in
            if !newValue {
                dataStore.filteredCharacters = dataStore.characters
            }
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(dataStore: DataStore())
    }
}

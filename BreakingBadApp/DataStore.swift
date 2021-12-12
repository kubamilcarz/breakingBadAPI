//
//  DataStore.swift
//  BreakingBadApp
//
//  Created by Kuba Milcarz on 10/12/2021.
//

import Foundation

class DataStore: ObservableObject {
    @Published var filteredCharacters = [Character]()
    @Published var characters = [Character]()
    @Published var quotes = [Quote]()
    @Published var episodes = [Episode]()
    
    func fetchCharacters(with data: [Character]) {
        characters = data
        filteredCharacters = data
    }
    
    func fetchQuotes(with data: [Quote]) {
        quotes = data
    }
    
    func fetchEpisodes(with data: [Episode]) {
        episodes = data
    }
}

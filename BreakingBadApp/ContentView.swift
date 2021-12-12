//
//  ContentView.swift
//  BreakingBadApp
//
//  Created by Kuba Milcarz on 10/12/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataStore = DataStore()
    
    var body: some View {
        TabView {
            CharactersView(dataStore: dataStore)
                .tabItem {
                    Label("Characters", systemImage: "person.crop.rectangle.stack")
                }
            SeasonsView(dataStore: dataStore)
                .tabItem {
                    Label("Seasons", systemImage: "play.rectangle.fill")
                }
            QuotesView(dataStore: dataStore)
                .tabItem {
                    Label("Quotes", systemImage: "quote.bubble.fill")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

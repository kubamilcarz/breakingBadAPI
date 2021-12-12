//
//  QuotesView.swift
//  BreakingBadApp
//
//  Created by Kuba Milcarz on 10/12/2021.
//

import SwiftUI

struct QuotesView: View {
    @ObservedObject var dataStore: DataStore
    var body: some View {
        NavigationView {
            List(dataStore.quotes, id: \.quote_id) { quote in
                ZStack(alignment: .topLeading) {
                    Image(systemName: "quote.opening")
                        .font(.largeTitle)
                        .foregroundColor(.gray).opacity(0.3)
                        .offset(x: -5, y: 0)
                    VStack(alignment: .leading) {
                        Text(quote.quote)
                            .padding([.leading, .top], 10)
                            .font(.headline)
                        HStack(alignment: .center) {
                            Spacer()
                            NavigationLink {
                                let character = findCharacter(by: quote.author)
                                CharacterDetailView(character: character)
                            } label: {
                                Text("~ \(quote.author)")
                                    .font(.body.italic())
                                    .foregroundColor(.gray)
                            }
                            
                        }.padding(.top, 5)
                    }
                }
                
            }
            .task {
                await loadData()
            }
            
            .navigationTitle("Quotes")
        }
    }
    
    func findCharacter(by name: String) -> Character {
        dataStore.characters.first(where: { $0.name == name }) ?? Character.dummy
    }
    
    func loadData() async {
        guard dataStore.quotes.isEmpty else { return }
        
        do {
            let url = URL(string: "https://www.breakingbadapi.com/api/quotes/")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let quotes = try decoder.decode([Quote].self, from: data)
            await MainActor.run {
                dataStore.fetchQuotes(with: quotes)
            }
        } catch {
            print("Downloading data failed.")
        }
    }
}

struct QuotesView_Previews: PreviewProvider {
    static var previews: some View {
        QuotesView(dataStore: DataStore())
    }
}

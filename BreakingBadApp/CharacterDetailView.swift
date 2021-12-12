//
//  CharacterDetailView.swift
//  BreakingBadApp
//
//  Created by Kuba Milcarz on 10/12/2021.
//

import SwiftUI

struct CharacterDetailView: View {
    var character: Character
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                AsyncImage(url: URL(string: character.img), scale: 3) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity, minHeight: 400, maxHeight: 400)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Nickname")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        Text(character.nickname)
                            .font(.headline)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Status")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        Text(character.status)
                            .font(.headline)
                            .foregroundColor(character.status == "Deceased" ? .red : .primary)
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Portrayed by")
                        Spacer()
                        Text(character.portrayed)
                            .font(.headline)
                    }
                    HStack {
                        Text("Appeared in")
                        Spacer()
                        HStack(spacing: 0) {
                            ForEach(character.appearance, id: \.self) { season in
                                ZStack {
                                    Circle().fill(.thinMaterial)
                                    Text("\(season)")
                                }
                                .frame(width: 30, height: 30)
                                .padding(.leading, 10)
                            }
                        }.padding(0)
                    }
                    HStack {
                        Text("Better Caul Soul")
                        Spacer()
                        HStack(spacing: 0) {
                            if character.better_call_saul_appearance.count > 1 {
                                ForEach(character.better_call_saul_appearance, id: \.self) { season in
                                    ZStack {
                                        Circle().fill(.thinMaterial)
                                        Text("\(season)")
                                    }
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 10)
                                }
                            } else {
                                Text("none")
                                    .foregroundColor(.gray)
                            }
                        }.padding(0)
                    }
                }
                
            }.padding()
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(character: .dummy)
    }
}

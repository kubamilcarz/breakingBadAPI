//
//  CharacterRow.swift
//  BreakingBadApp
//
//  Created by Kuba Milcarz on 10/12/2021.
//

import SwiftUI

struct CharacterRow: View {
    var character: Character
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: character.img), scale: 3) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                Text(character.nickname)
            }
            Spacer()
        }
    }
}

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRow(character: Character.dummy)
    }
}

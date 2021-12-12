//
//  Charactee.swift
//  BreakingBadApp
//
//  Created by Kuba Milcarz on 10/12/2021.
//

import Foundation

struct Character: Codable {
    let char_id: Int
    let name: String
    let birthday: String
    let occupation: [String]
    let img: String
    let status: String
    let nickname: String
    let appearance: [Int]
    let portrayed: String
    let category: String // split while displaying
    let better_call_saul_appearance: [Int]
    
    static let dummy = Character(char_id: 1, name: "Walter White", birthday: "07-08-1993", occupation: ["Teenager"], img: "https://vignette.wikia.nocookie.net/breakingbad/images/b/b4/Hector_BCS.jpg/revision/latest?cb=20170810091606", status: "Deceased", nickname: "El Acabra", appearance: [1, 2, 3, 4], portrayed: "Craig Jordan", category: "Breaking Bad, Better Call Saul", better_call_saul_appearance: [2])
}

//
//  Episode.swift
//  BreakingBadApp
//
//  Created by Kuba Milcarz on 10/12/2021.
//

import Foundation

struct Episode: Codable {
    let episode_id: Int
    let title: String
    let season: String
    let air_date: String
    let characters: [String]
    let episode: String
    let series: String
}

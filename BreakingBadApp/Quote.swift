//
//  Quote.swift
//  BreakingBadApp
//
//  Created by Kuba Milcarz on 10/12/2021.
//

import Foundation

struct Quote: Codable {
    let quote_id: Int
    let quote: String
    let author: String
    let series: String
}

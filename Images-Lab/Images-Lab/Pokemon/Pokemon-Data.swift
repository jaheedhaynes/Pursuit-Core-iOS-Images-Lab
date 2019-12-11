//
//  Pokemon-Data.swift
//  Images-Lab
//
//  Created by Jaheed Haynes on 12/10/19.
//  Copyright © 2019 Jaheed Haynes. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let cards: [Cards]
}
struct Cards: Decodable {
    let name: String
    let imageUrlHiRes: String
    let imageUrl: String
    let types: [String]?
    let set: String
    let weaknesses: [Weaknesses]?
}

struct Weaknesses: Decodable{
    let type: String
    let value: String
}

enum SearchScope {
    case first
}

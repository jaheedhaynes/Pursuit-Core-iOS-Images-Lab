//
//  Comic-Data.swift
//  Images-Lab
//
//  Created by Jaheed Haynes on 12/10/19.
//  Copyright © 2019 Jaheed Haynes. All rights reserved.
//

import Foundation

struct Comic: Decodable {
    let month: String
    var num: Int
    let year: String
    let img: String
    let title: String
    let day: String
}

//
//  Genres.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 25/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import Foundation

struct GenreList: Codable {
  let genres: [Genre]?
    
    
}

class Genre: Codable {
    let id: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

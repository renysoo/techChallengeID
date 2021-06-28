//
//  Movie.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 25/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import Foundation

struct MovieList: Codable {
  let count: Int?
  let results: [Movie]?
    
    
}

struct Movie: Codable, Equatable {

    let id: Int
    let title: String
    let overview: String
    let genre_ids: [Int]
    let video: Bool
    let posterPath: String?
    let releaseDate: String
        
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case genre_ids
        case video
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}


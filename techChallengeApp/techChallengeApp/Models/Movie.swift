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

struct Movie: Codable {

    let id: Int
    let title: String
    let overview: String
    let genre_ids: [Int]
    let posterPath: String?
    let releaseDate: String
        
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case genre_ids
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}

extension UserDefaults {
    var favoriteMovies: [Movie] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "favorite") else { return [] }
            return (try? PropertyListDecoder().decode([Movie].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "favorite")
        }
    }
}

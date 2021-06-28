//
//  UserDefaults.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 27/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import Foundation

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
    
    var genres: [Genre] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "genre") else { return [] }
            return (try? PropertyListDecoder().decode([Genre].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "genre")
        }
    }
}

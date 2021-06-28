//
//  Video.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 27/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import Foundation

struct VideoResult: Codable {
  let id: Int?
  let results: [Videos]?
}

class Videos: Codable {
    let key: String
    let site: String
    
    private enum CodingKeys: String, CodingKey {
        case key
        case site
    }
}

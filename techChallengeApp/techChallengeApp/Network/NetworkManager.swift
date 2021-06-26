//
//  Network.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 25/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import Foundation

import Foundation

final class NetworkManager {

    var movies: [Movie] = []

    private let domainUrlString = "https://api.themoviedb.org/3"
    private let APIkey = "95bfdaa2a1bd5ee3b9aa276b69888c40"

    func fetchTrending(completionHandler: @escaping ([Movie]) -> Void) {

    let url = URL(string: domainUrlString + "/trending/movie/day?api_key=" + APIkey)!

    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
      if let error = error {
        print("Error with fetching films: \(error)")
        return
      }

      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
        print("Error with the response, unexpected status code: \(response)")
        return
      }

      if let data = data,
        let filmSummary = try? JSONDecoder().decode(MovieList.self, from: data) {
        completionHandler(filmSummary.results ?? [])
      }
    })
    task.resume()
  }
    
    func fetchPoster(from url: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let url = URL(string: "https://image.tmdb.org/t/p/original" + url)!
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}


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


    private let domainUrlString = "https://api.themoviedb.org/3"
    private let APIkey = "95bfdaa2a1bd5ee3b9aa276b69888c40"

    func fetchTrending(completionHandler: @escaping ([Movie]) -> Void) {

    let url = URL(string: domainUrlString + "/trending/movie/day?api_key=" + APIkey)!

    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        if let error = error {
            print("Error with fetching films: \(error)")
            return
        }

      
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print("Error with the response, unexpected status code: \(String(describing: response))")
            return
        }

        if let data = data, let filmSummary = try? JSONDecoder().decode(MovieList.self, from: data) {
            completionHandler(filmSummary.results ?? [])
        }
    })
        task.resume()
  }
    
    func fetchSearch(term: String, completionHandler: @escaping ([Movie]) -> Void) {
        
        let escapedAdress = ("https://api.themoviedb.org/3/search/movie?api_key=95bfdaa2a1bd5ee3b9aa276b69888c40&query=" + term + "&include_adult=false").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        if let url = URL(string: escapedAdress ?? "") {
            
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    print("Error with fetching films: \(error)")
                    return
                }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
                else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }
                
                if let data = data,
                    let filmSummary = try? JSONDecoder().decode(MovieList.self, from: data) {
                    completionHandler(filmSummary.results ?? [])
                }
            })
            task.resume()
        }
    }
    
    func fetchVideo(movieID: Int, completionHandler: @escaping ([Videos]) -> Void) {
        
        let escapedAdress = ("https://api.themoviedb.org/3/movie/" + String(movieID) + "/videos?api_key=95bfdaa2a1bd5ee3b9aa276b69888c40")
        if let url = URL(string: escapedAdress) {
            
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    print("Error with fetching videos: \(error)")
                    return
                }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
                else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }
                
                if let data = data,
                    let videosResults = try? JSONDecoder().decode(VideoResult.self, from: data) {
                    completionHandler(videosResults.results ?? [])
                }
            })
            task.resume()
        }
    }
    
    func fetchGenres(completionHandler: @escaping ([Genre]) -> Void){
        let url = URL(string:"https://api.themoviedb.org/3/genre/movie/list?api_key=95bfdaa2a1bd5ee3b9aa276b69888c40&language=en-US")!

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

            if let error = error {
                print("Error with fetching genres: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(response)")
                    return
            }

            if let data = data, let genreList = try? JSONDecoder().decode(GenreList.self, from: data) {
                completionHandler(genreList.genres ?? [])
            }
        })
        task.resume()
    }
}


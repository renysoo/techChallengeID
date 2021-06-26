//
//  TrendingViewController + Extensions.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 26/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import UIKit

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesList?.count ?? 0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "moviesCell") as? MovieCustomCell)!
        cell.movieLabel.text = moviesList?[indexPath.row].title
        cell.movieLabel.contentMode = .bottomRight
        cell.yearLabel.text = String(moviesList?[indexPath.row].releaseDate.prefix(4) ?? "")
        cell.movieImage.loadImageUsingCache(withUrl: "https://image.tmdb.org/t/p/original" +  ((moviesList?[indexPath.row].posterPath) ?? ""))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newViewController = MovieDetailViewController(movie: (moviesList?[indexPath.row])!)
        self.navigationController?.pushViewController(newViewController, animated: true)

    }
    
    
}

extension TrendingViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchMovieBy(searchTerm: searchBar.text ?? "")
       }
       
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTask?.cancel()
        
        let task = DispatchWorkItem { [weak self] in
            if searchText == ""{
                self?.fetchTrendingMovies()
            } else {
                self?.searchMovieBy(searchTerm: searchText)
            }
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75, execute: task)
    }
    
    
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           fetchTrendingMovies()
       }
}

extension TrendingViewController: TrendingScreenDelegate {
    
}

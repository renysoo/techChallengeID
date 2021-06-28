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
        if moviesList?.count == 0 {
            screen.noResultsLabel.isHidden = false
        } else {
            screen.noResultsLabel.isHidden = true
        }
        return moviesList?.count ?? 0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "moviesCell") as? MovieCustomCell)!
        cell.movieLabel.text = moviesList?[indexPath.row].title
        cell.movieLabel.contentMode = .bottomRight
        cell.yearLabel.text = String(moviesList?[indexPath.row].releaseDate.prefix(4) ?? "")
        var url = "https://image.tmdb.org/t/p/original" + ((moviesList?[indexPath.row].posterPath) ?? "")
        if moviesList?[indexPath.row].posterPath == nil {
            url = "https://media.istockphoto.com/photos/error-picture-id1157134529?k=6&m=1157134529&s=612x612&w=0&h=xQvx08rYUPP8vv5c644AIbF7dI_Z1vBxub6gxXJR-9M="
        }
        cell.movieImage.loadImageUsingCache(withUrl: url)
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

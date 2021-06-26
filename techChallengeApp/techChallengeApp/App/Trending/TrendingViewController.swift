//
//  ViewController.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 24/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController {

    
    private var moviesList: [Movie]?
    
    let network = NetworkManager()

    private let screen = TrendingScreen()
    
    var searchTask: DispatchWorkItem?

    override func loadView() {
        self.view = screen
        screen.delegate = self
    }
    
    fileprivate func fetchTrendingMovies() {
        network.fetchTrending { [weak self] (movies) in
            self?.moviesList = movies
            DispatchQueue.main.async {
                self?.screen.moviesTableView.reloadData()
                
            }
        }
    }
    
    fileprivate func searchMovieBy(searchTerm: String) {
        network.fetchSearch(term: searchTerm) { [weak self] (movies) in
            self?.moviesList = movies
             DispatchQueue.main.async {
                self?.screen.moviesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screen.searchBar.delegate = self
        screen.moviesTableView.delegate = self
        screen.moviesTableView.dataSource = self
        screen.moviesTableView.register(MovieCustomCell.self, forCellReuseIdentifier: "moviesCell")
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        fetchTrendingMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

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


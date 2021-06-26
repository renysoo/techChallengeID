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

    private let screen = TrendingScreen()
    
    override func loadView() {
        self.view = screen
        screen.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screen.moviesTableView.delegate = self
        screen.moviesTableView.dataSource = self
        screen.moviesTableView.register(TrendingCustomCell.self, forCellReuseIdentifier: "moviesCell")
        
        NetworkManager().fetchTrending { [weak self] (movies) in
             self?.moviesList = movies
             DispatchQueue.main.async {
                self?.screen.moviesTableView.reloadData()
            }
        }
    }
}

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesList?.count ?? 0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "moviesCell") as? TrendingCustomCell)!
        cell.movieLabel.text = moviesList?[indexPath.row].title
        cell.movieLabel.contentMode = .bottomRight
        cell.yearLabel.text = String(moviesList?[indexPath.row].releaseDate.prefix(4) ?? "")
        cell.movieImage.loadImageUsingCache(withUrl: "https://image.tmdb.org/t/p/original" +  ((moviesList?[indexPath.row].posterPath)!))
        return cell
        
    }
    
    
}

extension TrendingViewController: TrendingScreenDelegate {
    
}


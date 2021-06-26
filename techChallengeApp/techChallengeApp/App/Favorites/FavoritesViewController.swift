//
//  FavoritesViewController.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 26/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import Foundation


import UIKit

class FavoritesViewController: UIViewController {

    
    private var favoritesList: [Movie]?

    private let screen = FavoritesScreen()
    
    override func loadView() {
        self.view = screen
        screen.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screen.moviesTableView.delegate = self
        screen.moviesTableView.dataSource = self
        screen.moviesTableView.register(MovieCustomCell.self, forCellReuseIdentifier: "moviesCell")
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        favoritesList = UserDefaults.standard.favoriteMovies
        screen.moviesTableView.reloadData()
        if favoritesList!.count == 0 {
            screen.noFavoritesLabel.isHidden = false
        } else {
            screen.noFavoritesLabel.isHidden = true
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritesList?.count ?? 0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "moviesCell") as? MovieCustomCell)!
        cell.movieLabel.text = favoritesList?[indexPath.row].title
        cell.movieLabel.contentMode = .bottomRight
        cell.yearLabel.text = String(favoritesList?[indexPath.row].releaseDate.prefix(4) ?? "")
        cell.movieImage.loadImageUsingCache(withUrl: "https://image.tmdb.org/t/p/original" +  ((favoritesList?[indexPath.row].posterPath)!))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newViewController = MovieDetailViewController(movie: (favoritesList?[indexPath.row])!)
        self.navigationController?.pushViewController(newViewController, animated: true)

    }
    
}

extension FavoritesViewController: FavoritesScreenDelegate {
    
}

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
        screen.moviesTableView.register(MovieCustomCell.self, forCellReuseIdentifier: "moviesCell")
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        NetworkManager().fetchTrending { [weak self] (movies) in
             self?.moviesList = movies
             DispatchQueue.main.async {
                self?.screen.moviesTableView.reloadData()
                
            }
        }
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

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesList?.count ?? 0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "moviesCell") as? MovieCustomCell)!
        cell.movieLabel.text = moviesList?[indexPath.row].title
        cell.movieLabel.contentMode = .bottomRight
        cell.yearLabel.text = String(moviesList?[indexPath.row].releaseDate.prefix(4) ?? "")
        cell.movieImage.loadImageUsingCache(withUrl: "https://image.tmdb.org/t/p/original" +  ((moviesList?[indexPath.row].posterPath)!))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newViewController = MovieDetailViewController(movie: (moviesList?[indexPath.row])!)
        self.navigationController?.pushViewController(newViewController, animated: true)

    }
    
}

extension TrendingViewController: TrendingScreenDelegate {
    
}


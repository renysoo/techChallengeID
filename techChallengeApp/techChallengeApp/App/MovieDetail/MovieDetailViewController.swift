//
//  MovieDetailViewController.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 24/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var presentedMovie: Movie?
    
    var genresList: [Genre] = UserDefaults.standard.genres

    
    init(movie: Movie) {
        super.init(nibName: "view", bundle: nil)
        let completeUrl = String("https://image.tmdb.org/t/p/original" + movie.posterPath!)
        screen.movieLabel.text = movie.title
        screen.movieImage.loadImageUsingCache(withUrl: completeUrl)
        screen.yearLabel.text = movie.releaseDate
        screen.overviewLabel.text = movie.overview
        presentedMovie = movie
        getPresentedMovieGenres()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let screen = MovieDetailScreen()
    
    override func loadView() {
        self.view = screen
        screen.delegate = self
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        changeColorFavoriteButton()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    

    @objc func favoriteButton() {
        if checkFavoriteStatus() {
            
            while UserDefaults.standard.favoriteMovies.contains(presentedMovie!) {
                if let itemToRemoveIndex = UserDefaults.standard.favoriteMovies.firstIndex(of: presentedMovie!) {
                UserDefaults.standard.favoriteMovies.remove(at: itemToRemoveIndex)
                }
            }
            
        } else {
            UserDefaults.standard.favoriteMovies.append(presentedMovie!)
        }
        changeColorFavoriteButton()
    }
    
    func changeColorFavoriteButton(){
        if checkFavoriteStatus() {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(favoriteButton))
            self.navigationItem.rightBarButtonItem?.tintColor = AppColors.red.color
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButton))
            self.navigationItem.rightBarButtonItem?.tintColor = AppColors.white.color
        }
    }
    
    func checkFavoriteStatus() -> Bool {
        if UserDefaults.standard.favoriteMovies.contains(presentedMovie!){
            return true
        } else {
            return false
        }
    }
    
    func getPresentedMovieGenres(){
        let presentedMovieGenres = genresList.filter({presentedMovie?.genre_ids.contains($0.id) as! Bool})
        self.screen.createGenreLabels(genres: presentedMovieGenres)
    }
}

extension MovieDetailViewController: MovieDetailScreenDelegate {
    
}

//
//  MovieDetailViewController.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 24/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import UIKit
import WebKit

class MovieDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var presentedMovie: Movie?
    
    var genresList: [Genre] = UserDefaults.standard.genres

    init(movie: Movie) {
        super.init(nibName: "view", bundle: nil)
        var completeUrl = String("https://image.tmdb.org/t/p/original" + (movie.posterPath ?? ""))
        if movie.posterPath == nil {
            completeUrl = "https://media.istockphoto.com/photos/error-picture-id1157134529?k=6&m=1157134529&s=612x612&w=0&h=xQvx08rYUPP8vv5c644AIbF7dI_Z1vBxub6gxXJR-9M="
        }

        screen.movieLabel.text = movie.title
        screen.movieImage.loadImageUsingCache(withUrl: completeUrl)
        screen.yearLabel.text = movie.releaseDate
        screen.overviewLabel.text = movie.overview
        presentedMovie = movie
        getPresentedMovieGenres()
        getMovieVideo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let screen = MovieDetailScreen()
    
    override func loadView() {
        self.view = screen
        screen.delegate = self
        screen.youtubeView.navigationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        screen.scrollView.contentSize = screen.contentView.bounds.size
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        screen.scrollView.delegate = self
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
    
    func getMovieVideo(){
        NetworkManager().fetchVideo(movieID: presentedMovie!.id, completionHandler: { [weak self] (videos) in
            DispatchQueue.main.async {
                if videos.contains(where: {$0.site == "YouTube"}) {
                    let videoToShow = videos.filter({$0.site == "YouTube"})
                    let urlString = "https://www.youtube.com/embed/" + videoToShow[0].key
                    let url = URL(string: urlString)
                    let request = URLRequest(url: url!)
                    print(url)
                    print(request)
                    self?.screen.youtubeView.load(request)
                } else {
                    let url = URL(string: "https://media.istockphoto.com/photos/error-picture-id1157134529?k=6&m=1157134529&s=612x612&w=0&h=xQvx08rYUPP8vv5c644AIbF7dI_Z1vBxub6gxXJR-9M=")
                    self?.screen.youtubeView.load(URLRequest(url: url!))
                }
            }
        })
    }
}

extension MovieDetailViewController: MovieDetailScreenDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        screen.activityIndicator.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        screen.activityIndicator.isHidden = true
    }
}

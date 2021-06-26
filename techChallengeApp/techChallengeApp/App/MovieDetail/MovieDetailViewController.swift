//
//  MovieDetailViewController.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 24/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    init(url:String, title: String, year: String, overview: String) {
        super.init(nibName: "view", bundle: nil)
        screen.movieLabel.text = title
        screen.movieImage.loadImageUsingCache(withUrl: url)
        screen.yearLabel.text = year
        screen.overviewLabel.text = overview
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
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension MovieDetailViewController: MovieDetailScreenDelegate {
    
}

//
//  MovieDetailViewController.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 24/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private let screen = MovieDetailScreen()
    
    override func loadView() {
        self.view = screen
        screen.delegate = self
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
}

extension MovieDetailViewController: MovieDetailScreenDelegate {
    
}
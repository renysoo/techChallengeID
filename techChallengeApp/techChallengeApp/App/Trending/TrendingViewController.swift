//
//  ViewController.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 24/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController {

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
        
    }


}

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        33
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "moviesCell") as? TrendingCustomCell)!
        cell.movieImage.image = UIImage(named: "ithPoster.jpg")
        cell.movieLabel.text = "In the Heights"
        cell.movieLabel.contentMode = .bottomRight
        cell.yearLabel.text = "2021"
        return cell
        
    }
    
    
}

extension TrendingViewController: TrendingScreenDelegate {
    
}


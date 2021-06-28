//
//  ViewController.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 24/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController {

    
    var moviesList: [Movie]?
    
    let network = NetworkManager()

    let screen = TrendingScreen()
    
    var searchTask: DispatchWorkItem?
    
    let refreshControl = UIRefreshControl()

    override func loadView() {
        self.view = screen
        screen.delegate = self
    }
    
    func fetchTrendingMovies() {
        network.fetchTrending { [weak self] (movies) in
            self?.moviesList = movies
            DispatchQueue.main.async {
                self?.screen.moviesTableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc func refreshTable(){
        fetchTrendingMovies()
    }
    
    func searchMovieBy(searchTerm: String) {
        network.fetchSearch(term: searchTerm) { [weak self] (movies) in
            self?.moviesList = movies
             DispatchQueue.main.async {
                self?.screen.moviesTableView.reloadData()
            }
        }
    }
    
    fileprivate func setupTableView() {
        screen.searchBar.delegate = self
        screen.moviesTableView.delegate = self
        screen.moviesTableView.dataSource = self
        screen.moviesTableView.refreshControl = refreshControl
        refreshControl.tintColor = AppColors.white.color
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        screen.moviesTableView.register(MovieCustomCell.self, forCellReuseIdentifier: "moviesCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false 
        view.addGestureRecognizer(tap)
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
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}




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

    var presentingList: [Movie]?
    
    var favoritesList: [Movie]?

    let screen = FavoritesScreen()
    
    var searchTask: DispatchWorkItem?

    override func loadView() {
        self.view = screen
        screen.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen.searchBar.delegate = self
        screen.moviesTableView.delegate = self
        screen.moviesTableView.dataSource = self
        screen.moviesTableView.register(MovieCustomCell.self, forCellReuseIdentifier: "moviesCell")
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        favoritesList = UserDefaults.standard.favoriteMovies
        presentingList = favoritesList
        screen.moviesTableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func searchFavorite(term: String){
        presentingList = favoritesList?.filter({$0.title.lowercased().contains(term.lowercased())})
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}



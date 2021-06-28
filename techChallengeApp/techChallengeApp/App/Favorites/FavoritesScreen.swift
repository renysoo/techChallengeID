//
//  FavoritesScreen.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 26/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import UIKit

protocol FavoritesScreenDelegate {
    
}

class FavoritesScreen: UIView {
    
    var delegate: FavoritesScreenDelegate!
    
    init() {
        
        super.init(frame: .zero)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.tintColor = AppColors.tab.color
        searchBar.barTintColor = AppColors.background.color
        searchBar.backgroundColor = .clear
        searchBar.placeholder = " Search Here....."
        searchBar.sizeToFit()
        searchBar.isTranslucent = true
        searchBar.searchTextField.backgroundColor = AppColors.tab.color
        searchBar.searchTextField.textColor = AppColors.white.color
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    
    let moviesTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isEditing = false
        table.allowsSelection = true
        table.separatorStyle = .none
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    let noFavoritesLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "You don't have any movie\n on your favorites list :("
        view.numberOfLines = 2
        view.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        view.textAlignment = .center
        view.sizeToFit()
        view.textColor = AppColors.white.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let noResultsLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "We couldn't find the movie\nyou were looking for :("
        view.numberOfLines = 2
        view.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        view.textAlignment = .center
        view.sizeToFit()
        view.textColor = AppColors.white.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
}

extension FavoritesScreen: ViewCode {
    func buildView() {
        addSubview(moviesTableView)
        addSubview(searchBar)
        addSubview(noFavoritesLabel)
        addSubview(noResultsLabel)
        self.backgroundColor = AppColors.background.color
    }
    
    func setupConstraints() {
        
        searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        searchBar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        moviesTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        moviesTableView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        moviesTableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9, constant: 0).isActive = true
        moviesTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        moviesTableView.rowHeight = 150
        
        noFavoritesLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        noFavoritesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        noResultsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        noResultsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

    }
    
    func setupAdditionalConfigs() {
        noResultsLabel.isHidden = true
    }
    
}

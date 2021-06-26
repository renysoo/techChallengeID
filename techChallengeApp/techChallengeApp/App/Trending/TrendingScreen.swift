//
//  TrendingScreen.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 24/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import UIKit

protocol TrendingScreenDelegate {
    
}

class TrendingScreen: UIView {
    
    var delegate: TrendingScreenDelegate!
    
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
//        table.rowHeight = CGFloat(88)
//        table.contentInset.bottom = UIScreen.main.bounds.height/10
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    
    
}

extension TrendingScreen: ViewCode {
    func buildView() {
        addSubview(moviesTableView)
        addSubview(searchBar)
        self.backgroundColor = AppColors.background.color
    }
    
    func setupConstraints() {
        
        searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        searchBar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        moviesTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        moviesTableView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        moviesTableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: 0).isActive = true
        moviesTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        moviesTableView.rowHeight = 150
    }
    
    func setupAdditionalConfigs() {
        
    }
    
}

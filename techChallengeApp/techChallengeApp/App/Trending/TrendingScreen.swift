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

 class TrendingScreen {
    
    var delegate: TrendingScreenDelegate!
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let moviesTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isEditing = false
        table.allowsSelection = true
        table.separatorStyle = .none
//        table.rowHeight = CGFloat(88)
        table.contentInset.bottom = UIScreen.main.bounds.height/10
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    
    
}

extension TrendingScreen: ViewCode {
    func buildView() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupAdditionalConfigs() {
        
    }
    
}

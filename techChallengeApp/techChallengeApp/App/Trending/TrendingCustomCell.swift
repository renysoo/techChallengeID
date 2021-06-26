//
//  TrendingCustomCell.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 24/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import UIKit

class TrendingCustomCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        self.backgroundColor = .none
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cardView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = AppColors.card.color
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 6
        return view
    }()
    
    let movieImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 16
        return view
    }()
    
    let movieLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = ""
        view.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 3
        view.textAlignment = .right
        view.sizeToFit()
        view.textColor = AppColors.white.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let yearLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = ""
        view.font = UIFont.systemFont(ofSize: 14, weight: .light)
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 1
        view.textColor = AppColors.white.color
        view.textAlignment = .right
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
}
extension TrendingCustomCell: ViewCode {
    func buildView() {
        addSubview(cardView)
        cardView.addSubview(movieImage)
        cardView.addSubview(movieLabel)
        cardView.addSubview(yearLabel)
    }
    
    
    func setupConstraints() {
        
        cardView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        cardView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        cardView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cardView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true


        movieImage.widthAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.73).isActive = true
        movieImage.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.73).isActive = true
        movieImage.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        
        yearLabel.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.56).isActive = true
        yearLabel.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -2).isActive = true
        yearLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        
        movieLabel.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.56).isActive = true
        movieLabel.bottomAnchor.constraint(equalTo: yearLabel.topAnchor, constant: -5).isActive = true
        movieLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        
    }
    
    func setupAdditionalConfigs() {
    }
    
    
}

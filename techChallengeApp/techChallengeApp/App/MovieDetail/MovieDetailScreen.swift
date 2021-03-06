//
//  MovieDetailScreen.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 24/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import UIKit
import WebKit

protocol MovieDetailScreenDelegate {
    
}

class MovieDetailScreen: UIView, UIScrollViewDelegate {
    
    var delegate: MovieDetailScreenDelegate!
    
    init() {
        
        super.init(frame: .zero)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)//mudar aqui depois
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = true
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        view.image = UIImage(named: "ithPoster.jpg")
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 16
        return view
    }()
    
    let yearLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "2021"
        view.font = UIFont.systemFont(ofSize: 14, weight: .light)
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 1
        view.textColor = AppColors.white.color
        view.textAlignment = .right
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let movieLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "In the Heights"
        view.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 3
        view.textAlignment = .right
        view.sizeToFit()
        view.textColor = AppColors.white.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let youtubeView: WKWebView = {
        let view = WKWebView(frame: .zero)
        view.allowsLinkPreview = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
        view.startAnimating()
        view.color = AppColors.tab.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let overviewLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "A film version of the Broadway musical in which Usnavi, a sympathetic New York bodega owner, saves every penny every day as he imagines and sings about a better life."
        view.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 0
        view.textAlignment = .right
        view.sizeToFit()
        view.textColor = AppColors.white.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

extension MovieDetailScreen: ViewCode {
    func buildView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(cardView)
        cardView.addSubview(movieImage)
        cardView.addSubview(movieLabel)
        cardView.addSubview(yearLabel)
        cardView.addSubview(overviewLabel)
        cardView.addSubview(youtubeView)
        youtubeView.addSubview(activityIndicator)
        self.backgroundColor = AppColors.background.color

    }
    
    func setupConstraints() {
        let screenBounds = UIScreen.main.bounds
        
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 20).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: screenBounds.height*0.02).isActive = true
        cardView.bottomAnchor.constraint(equalTo: youtubeView.bottomAnchor, constant: screenBounds.height*0.04).isActive = true
        cardView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85).isActive = true
        cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true


        movieImage.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.8).isActive = true
        movieImage.heightAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.8).isActive = true
        movieImage.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        movieImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: screenBounds.height*0.04).isActive = true
        
        movieLabel.widthAnchor.constraint(equalTo: movieImage.widthAnchor).isActive = true
        movieLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: screenBounds.height*0.03).isActive = true
        movieLabel.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor).isActive = true
        
        yearLabel.topAnchor.constraint(equalTo: movieLabel.bottomAnchor, constant: 5).isActive = true
        yearLabel.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor).isActive = true

        overviewLabel.widthAnchor.constraint(equalTo: movieImage.widthAnchor).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor).isActive = true

        youtubeView.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.8).isActive = true
        youtubeView.heightAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.45).isActive = true
        youtubeView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        youtubeView.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: youtubeView.centerYAnchor).isActive = true

    }
    
    func setupAdditionalConfigs() {
    }
    
    
}

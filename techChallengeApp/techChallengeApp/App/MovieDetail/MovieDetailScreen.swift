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
        let url = URL(string: "https://www.youtube.com/embed/6JnN1DmbqoU")
        view.load(URLRequest(url: url!))
        view.allowsLinkPreview = true
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
    
    func createGenreLabels(genres:[Genre]){
        var trailingVariation = movieImage.trailingAnchor
        for genre in genres {
            
            if genres.count > 3 {
                if genre.name == genres[3].name {
                    break
                }
            }
            
            let genreLabel: UILabel = {
                let view = UILabel(frame: .zero)
                view.text = genre.name
                view.font = UIFont.systemFont(ofSize: 12, weight: .regular)
                view.textAlignment = .center
                view.sizeToFit()
                view.textColor = AppColors.white.color
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            
            let genreLabelStroke: UIView = {
                let view = UIView(frame: .zero)
                view.tintColor = .clear
                view.layer.borderColor = AppColors.white.color.cgColor
                view.layer.borderWidth = 1
                view.layer.cornerRadius = 10
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            
            cardView.addSubview(genreLabel)
            cardView.addSubview(genreLabelStroke)
            
            genreLabel.centerXAnchor.constraint(equalTo: genreLabelStroke.centerXAnchor).isActive = true
            genreLabel.centerYAnchor.constraint(equalTo: genreLabelStroke.centerYAnchor).isActive = true
            
            if genre.name == genres[0].name {
                genreLabelStroke.trailingAnchor.constraint(equalTo: trailingVariation, constant: 0).isActive = true
            } else {
                genreLabelStroke.trailingAnchor.constraint(equalTo: trailingVariation, constant: -5).isActive = true
            }
            genreLabelStroke.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant:6).isActive = true
            genreLabelStroke.widthAnchor.constraint(equalTo: genreLabel.widthAnchor, constant: 15).isActive = true
            genreLabelStroke.heightAnchor.constraint(equalTo: genreLabel.heightAnchor, constant: 5).isActive = true
            
            overviewLabel.topAnchor.constraint(equalTo: genreLabelStroke.bottomAnchor, constant: 8).isActive = true

            trailingVariation = genreLabelStroke.leadingAnchor
        }
    }
}

extension MovieDetailScreen: ViewCode {
    func buildView() {
        addSubview(cardView)
        cardView.addSubview(movieImage)
        cardView.addSubview(movieLabel)
        cardView.addSubview(yearLabel)
        cardView.addSubview(overviewLabel)
        addSubview(youtubeView)
        self.backgroundColor = AppColors.background.color

    }
    
    func setupConstraints() {
        let screenBounds = UIScreen.main.bounds
        
        cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: screenBounds.height*0.02).isActive = true
        cardView.bottomAnchor.constraint(equalTo: youtubeView.bottomAnchor, constant: screenBounds.height*0.04).isActive = true
        cardView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        cardView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true


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
        youtubeView.heightAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.5).isActive = true
        youtubeView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        youtubeView.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20).isActive = true
    }
    
    func setupAdditionalConfigs() {
    }
    
    
}

//
//  MovieDetailScreen + Extensions.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 27/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import UIKit
import WebKit

extension MovieDetailScreen {
    
    func createGenreLabels(genres:[Genre]){
        var trailingVariation = movieImage.trailingAnchor
        if genres.isEmpty {
            overviewLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 8).isActive = true
        }
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


//
//  ViewCode.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 24/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import Foundation

protocol ViewCode {
    func buildView()
    func setupConstraints()
    func setupAdditionalConfigs()
    func setupView()
}

extension ViewCode {
    func setupView() {
        buildView()
        setupConstraints()
        setupAdditionalConfigs()
    }
}

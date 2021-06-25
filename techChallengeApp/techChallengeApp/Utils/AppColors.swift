//
//  AppColors.swift
//  techChallengeApp
//
//  Created by René Melo de Lucena on 24/06/21.
//  Copyright © 2021 René Melo de Lucena. All rights reserved.
//

import UIKit

enum AppColors {
    case background, red, white, card, tab
    
    var color: UIColor{
        switch self {
        case .background:
            return UIColor(named: "backgroundColor")!
        case .red:
            return UIColor(named: "redColor")!
        case .white:
            return UIColor(named: "whiteColor")!
        case .card:
            return UIColor(named: "cardColor")!
        case .tab:
            return UIColor(named: "tabColor")!
        }
    }
}

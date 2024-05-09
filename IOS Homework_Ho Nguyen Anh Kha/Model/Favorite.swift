//
//  Favorite.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 9/5/24.
//

import Foundation
import UIKit

enum TransType: String {
    case CUBC
    case Mobile
    case PMF
    case CreditCard
    
    var image: UIImage? {
        switch self {
        case .CUBC:
            return UIImage(named: "button00ElementScrollTree")
        case .Mobile:
            return UIImage(named: "button00ElementScrollMobile")
        case .PMF:
            return UIImage(named: "button00ElementScrollBuilding")
        case .CreditCard:
            return UIImage(named: "button00ElementScrollMobile")
        }
    }
}

struct Favorite: Codable, Hashable {
    let nickname: String
    let transType: String
}

struct FavoriteResult: Codable, Hashable {
    let favoriteList: [Favorite]
}

struct ListFavoriteResponse: Codable, Hashable {
    let msgCode: String
    let msgContent: String
    let result: FavoriteResult
}

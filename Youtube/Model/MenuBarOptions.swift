//
//  MenuBarOptions.swift
//  Youtube
//
//  Created by Julio Collado on 12/19/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

enum MenuBarOptions: Int, CaseIterable {
    case Home, Trending, Subscriptions, Library
    
    var description: String {
        switch self {
        case .Home:
            return "Home"
        case .Trending:
            return "Trending"
        case .Subscriptions:
            return "Subscriptions"
        case .Library:
            return "Library"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Home:
            return #imageLiteral(resourceName: "Home")
        case .Trending:
             return #imageLiteral(resourceName: "Trending")
        case .Subscriptions:
             return #imageLiteral(resourceName: "Subscriptions")
        case .Library:
             return #imageLiteral(resourceName: "Library")
        }
    }
}

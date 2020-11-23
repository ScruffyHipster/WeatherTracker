//
//  Constants.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import UIKit

///File for storing constants through out application
struct Constants {
    // MARK: - Static Strings
    static let apiKey = "API_KEY"
    static let baseURL = "BASE_URL"
    
    enum UserDefaultsIdentifiers {
        case favouriteLocations
        
        var id: String {
            switch self {
            case .favouriteLocations:
                return "FavouriteLocations"
            }
        }
    }
    
    enum TableViewIdentifiers {
        case locationCell
        case favouriteCell
        case notSearchedCell
        
        var id: String {
            switch self {
            case .locationCell:
                return "LocationCell"
            case .favouriteCell:
                return "FavouriteCell"
            case .notSearchedCell:
                return "NotSearchedCell"
            }
        }
    }
    
    enum NotificationDictKeys {
        case selectedCell
        
        var id: String {
            switch self {
            case .selectedCell:
                return "selectedCell"
            }
        }
    }
}

enum StoryboardIdentifiers: String {
    case main = "Main"
    
    var identifier: String { rawValue }
    
    static func access(storyboard: Self) -> UIStoryboard {
        UIStoryboard(name: storyboard.rawValue, bundle: nil)
    }
}

enum Endpoints {
    case weather(String)
    
    var endpoint: String {
        switch self {
        case .weather(let city):
            return "q=\(city)"
        }
    }
    
}



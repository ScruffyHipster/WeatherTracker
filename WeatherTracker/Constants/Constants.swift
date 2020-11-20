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



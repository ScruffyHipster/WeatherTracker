//
//  Constants.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import UIKit



enum StoryboardIdentifiers: String {
    case main = "Main"
    
    var identifier: String { rawValue }
    
    static func access(storyboard: Self) -> UIStoryboard {
        UIStoryboard(name: storyboard.rawValue, bundle: nil)
    }
}





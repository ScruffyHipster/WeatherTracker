//
//  WeatherCellInfo.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 20/11/2020.
//

import Foundation

/// Model which represents the data that can be displayed in a table view cell
struct WeatherCellInfo {
    
    var location: String
    var country: String
    var windSpeed: Double
    var temp: Double
    var windDirection: Int
    
}

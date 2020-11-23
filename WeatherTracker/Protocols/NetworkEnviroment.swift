//
//  NetworkEnviroment.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import Foundation

/// Provides a individual enviroment for network contexts
protocol NetworkEnviroment {
    
    var apiKey: String { get }
    var baseUrlString: String { get }
    
    func createUrl(endpoint: Endpoints) -> String
    
}

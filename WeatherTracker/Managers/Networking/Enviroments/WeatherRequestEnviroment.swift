//
//  WeatherRequestEnviroment.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import Foundation

/// Provides a env context for network requests
struct WeatherNetworkEnviroment: NetworkEnviroment {
    
    /// API key, please find in build settings
    var apiKey: String {
        Bundle.main.object(forInfoDictionaryKey: Constants.apiKey) as! String
    }
    
    /// /// Base url, please find in build settings
    var baseUrlString: String {
        Bundle.main.object(forInfoDictionaryKey: Constants.baseURL) as! String
    }
    
    /// Creates URL for webcall
    ///
    /// - Parameters:
    ///   - searchParam:
    ///   - searchTerm: Allows choice between .id & .search
    /// - Returns: URLRequest
    func createUrl(endpoint: Endpoints) -> String {
        let term = endpoint.endpoint.replacingOccurrences(of: " ", with: "+").lowercased()
        return baseUrlString.appending("\(term)&units=metric&appid=\(apiKey)")
    }
    
}

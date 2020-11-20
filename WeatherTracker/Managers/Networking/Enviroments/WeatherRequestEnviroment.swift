//
//  WeatherRequestEnviroment.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import Foundation

/// Provides a env context for network requests
struct WeatherNetworkEnviroment: NetworkEnviroment {

    var apiKey: String {
        Bundle.main.object(forInfoDictionaryKey: Constants.apiKey) as! String
    }

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
        return baseUrlString.appending("\(endpoint.endpoint)/?key=\(apiKey)")
    }

}

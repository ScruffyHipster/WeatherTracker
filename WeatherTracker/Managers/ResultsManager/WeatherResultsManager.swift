//
//  WeatherResultsManager.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import Foundation
import Alamofire

/// Handles the requests to the open weather api and handler for returned data
final class WeatherResultsManager<Object: Codable>: ResultsManagerProtocol {
    
    var network: NetworkRequestor
    var resultsHandler: ((Result<Object, AFError>) -> Void)?
    
    init(network: NetworkRequestor = NetworkRequestor(session: .init(),
                                                      env: WeatherNetworkEnviroment())) {
        self.network = network
    }
    
    // MARK: - Methods
    
    /// Search for city results
    /// - Parameter endpoint: endpoint in which to search
    func search(endpoint: Endpoints) {
        guard let resultsHandler = resultsHandler else {
            fatalError("⚠️ didn't set a handler for the results manager")
        }
        network.fetchFromApi(endpoint, completion: resultsHandler)
    }
    
}

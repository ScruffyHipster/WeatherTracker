//
//  NetworkRequestor.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import Foundation
import Alamofire

/// Handles the network requests and parsing of decodable objects
final class NetworkRequestor: NetworkRequestorProtocol  {
    
    // MARK:  Properties
    var session: Session
    var env: NetworkEnviroment
    
    // MARK:  Lifecycle methods
    init(session: Session = .default,
         env: NetworkEnviroment) {
        self.session = session
        self.env = env
    }
    
    // MARK: - Public methods
    
    /// Fetches Json and decodes
    /// - Parameters:
    ///   - url: url endpoint
    ///   - completion: returns result type
    public func fetchDecodable<T: Decodable>(_ url: String, completion: @escaping (Result<T, AFError>) -> Void) {
        let request = self.session.request(url)
            .validate(statusCode: 200..<300)
        request.responseDecodable(of: T.self, queue: .main) { (response) in
            completion(response.result)
        }
    }
    
}

/// Enviroment used for making specific weather requests
extension NetworkRequestor {
    
    /// Fetches weather from API
    /// - Parameters:
    ///   - endpoint: endpoint case
    ///   - completion: returns a Result type of T
    public func fetchFromApi<T: Codable>(_ endpoint: Endpoints, completion: @escaping ((Result<T, AFError>) -> Void)) {
        let url = env.createUrl(endpoint: endpoint)
        self.fetchDecodable(url, completion: completion)
    }
    
}

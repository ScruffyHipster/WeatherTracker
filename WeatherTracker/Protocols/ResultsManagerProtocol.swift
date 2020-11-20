//
//  ResultsManagerProtocol.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import Foundation
import Alamofire

/// used to provide handler for results callback
protocol ResultsManagerProtocol {
    associatedtype T: Codable
    var network: NetworkRequestor { get set }
    var resultsHandler: ((Result<T, AFError>) -> Void)? { get set }
}

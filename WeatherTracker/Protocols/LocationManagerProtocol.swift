//
//  LocationManagerProtocol.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 23/11/2020.
//

import Foundation
import CoreLocation

/// Provides conformance for the location manager
protocol LocationManagerProtocol: class {
    
    var manager: CLLocationManager? { get }
    var handler: ((CLPlacemark?, Error?) -> Void)? { get set }
    
    func start()
    
}

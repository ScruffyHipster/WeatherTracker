//
//  LocationManager.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 20/11/2020.
//

import UIKit
import CoreLocation

protocol LocationManagerProtocol: class {
    var manager: CLLocationManager? { get }
    var handler: ((CLPlacemark?, Error?) -> Void)? { get set }
    
    func start()
}

/// Location manager and CLLocationManagerDelegate.
/// 
class LocationManager: NSObject, LocationManagerProtocol, CLLocationManagerDelegate {
    
    
    //MARK: - Properties
    var manager: CLLocationManager?
    var handler: ((CLPlacemark?, Error?) -> Void)?
    private var geocoder: CLGeocoder = CLGeocoder()
    
    //MARK: - Life cycle
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.manager = locationManager
    }
    
    //MARK: - Methods
    func start() {
        manager?.delegate = self
        manager?.requestWhenInUseAuthorization()
        manager?.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Found user's location: \(location)")
            decodeCityFrom(location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
        handler?(nil, error)
    }
    
    private func decodeCityFrom(_ location: CLLocation) {
        geocoder.reverseGeocodeLocation(location, completionHandler: { [weak self] placemarks, error in
            guard let self = self else { return }
            if let placemark = placemarks?.first {
                self.handler?(placemark, nil)
            } else {
                self.handler?(nil, error)
            }
        })
    }
    
}

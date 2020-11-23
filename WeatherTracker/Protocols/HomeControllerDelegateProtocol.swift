//
//  HomeControllerDelegate.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 23/11/2020.
//

import UIKit

/// Delegate for the home view controller logic to be astracted which doesn't include setting up views etc.
protocol HomeControllerDataSourceDelegate: class {
    
    func didGetResult(_ result: WeatherRequest)
    
    func presentError(_ error: UIAlertController)
    
}

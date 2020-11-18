//
//  Coordinator.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import UIKit

/// Provides conformamc for protocols
protocol Coordinator: class {

    var children: [Coordinator]? { get set }
    var navigationController: UINavigationController { get set }

    func start()
}


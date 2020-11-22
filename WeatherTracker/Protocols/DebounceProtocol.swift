//
//  DebounceProtocol.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 20/11/2020.
//

import Foundation

/// Provides debounce confromance
protocol DebounceProtocol {
    var timer: Timer? { get set }
    var delay: TimeInterval { get set }
    var handler: (() -> ())? { get set }
}

//
//  UserDefaultsProtocol.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import Foundation

/// Provides conformnace for a user defaults manager
protocol UserDefaultsManagerProtocol {
    associatedtype Object
    var userDefaults: UserDefaults { get set }
    var defaultsReturnDataHandler: (([Object]?, UserDefaultsError?) -> Void)? { get set }
}

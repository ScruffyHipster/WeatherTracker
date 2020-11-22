//
//  UserDefaults++Extentions.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import Foundation

extension UserDefaults {

    /// Saves  the objects . Will remove the last value if greater than the total
    /// - Parameter term: weather result to be saved
    func saveItem<T: Codable>(_ object: T, total: Int = 10) {
        guard let data = value(forKey: Constants.UserDefaultsIdentifiers.favouriteLocations.id) as? Data else {
            self.set(try? PropertyListEncoder().encode([object]), forKey: Constants.UserDefaultsIdentifiers.favouriteLocations.id)
            return
        }
        let previousSearches = try? PropertyListDecoder().decode([T].self, from: data)
        guard var previousSearchesArray = previousSearches else {
            print("An error occured fetching existing saved locations")
            return
        }
        if !previousSearchesArray.isEmpty {
            previousSearchesArray.insert(object, at: 0)
            if previousSearchesArray.count > total {
                previousSearchesArray.removeLast()
            }
            updateWith(previousSearchesArray, key: Constants.UserDefaultsIdentifiers.favouriteLocations.id)
        } else {
            previousSearchesArray.append(object)
            updateWith(previousSearchesArray, key: Constants.UserDefaultsIdentifiers.favouriteLocations.id)
        }
    }

    /// updates the user defaults with the passed array
    /// - Parameters:
    ///   - data: the data to overwrite the current data linked to key
    ///   - key: description key
    func updateWith(_ data: [Any], key: String) {
        self.set(try? PropertyListEncoder().encode(data as? [WeatherRequest]), forKey: key)
    }

}

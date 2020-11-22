//
//  UserDefaultsManager.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import Foundation

enum UserDefaultsError: Error {
    case noObjectForTerm
}

/// Handles read and write access to user defaults
class UserDefaultsManager<T>: UserDefaultsManagerProtocol {

    // MARK: - Propeties
    var userDefaults: UserDefaults
    var defaultsReturnDataHandler: (([T]?, UserDefaultsError?) -> Void)?

    // MARK: - Init methods

    /// Init method for user defaults manager
    /// - Parameters:
    ///   - userDefaults: the user defaults instance, defautls to standard
    ///   - closure: used as the return data handler
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
}


/// Handler for using userdefaults with search objects
final class WeatherUserDefaultsManager: UserDefaultsManager<WeatherRequest> {
    
    // MARK: - Methods
    /// Will save a weather request
    /// - Parameter object: weather request object
    func save(_ object: WeatherRequest) {
        userDefaults.saveItem(object)
    }

    /// Retrive objects
    /// - Parameter key: value of objects
    func retriveObjectsFor(key: String) {
        guard let data = userDefaults.value(forKey: key) as? Data else {
            defaultsReturnDataHandler?(nil, UserDefaultsError.noObjectForTerm)
            return
        }
        let objects = try? PropertyListDecoder().decode([WeatherRequest].self, from: data)
        defaultsReturnDataHandler?(objects, nil)
    }

    /// Deletes an object from array at specified index
    /// - Parameters:
    ///   - index: index in which to remove at
    ///   - key: key for object array
    func deleteObject(object: WeatherRequest, key: String) {
        guard let data = userDefaults.value(forKey: key) as? Data else {
            defaultsReturnDataHandler?(nil, UserDefaultsError.noObjectForTerm)
            return
        }
        var objects = try? PropertyListDecoder().decode([WeatherRequest].self, from: data)
        let object = objects?.filter({
            $0.name == object.name
        })
        objects?.removeAll(where: {$0.name == object?.first?.name})
        userDefaults.updateWith(objects ?? [], key: key)
    }
    
}


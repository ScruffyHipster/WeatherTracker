//
//  PersistenceTests.swift
//  WeatherTrackerTests
//
//  Created by Thomas Murray on 22/11/2020.
//

import XCTest
@testable import WeatherTracker

class PersistenceTests: XCTestCase {

    var mockWeatherRequest = WeatherRequest(coord: .init(lon: 0.0, lat: 0.0),
                                            weather: [],
                                            base: "testData",
                                            main: .init(temp: 0.0,
                                                        feelsLike: 0.0,
                                                        tempMin: 0.0,
                                                        tempMax: 0.0,
                                                        pressure: 0,
                                                        humidity: 0),
                                            visibility: 0,
                                            wind: .init(speed: 0,
                                                        deg: 0),
                                            clouds: .init(all: 0),
                                            dt: 0,
                                            sys: .init(type: 0,
                                                       id: 0,
                                                       country: "",
                                                       sunrise: 0,
                                                       sunset: 0),
                                            timezone: 0,
                                            id: 0,
                                            name: "",
                                            cod: 0)

    func testUserDefaultsSavesAndRetrivesSearchTermStringObject() {
        
        
        guard let mockDefaults = UserDefaults(suiteName: "Test") else { return }
        let mockDefaultsManager = WeatherUserDefaultsManager(userDefaults: mockDefaults)
        
        mockDefaultsManager.defaultsReturnDataHandler = { (results, error) in
            if let results = results {
                XCTAssertEqual(results.first?.base, "testData", "Strings should match and be value testData")
                mockDefaults.removeObject(forKey: Constants.UserDefaultsIdentifiers.favouriteLocations.id)
            } else {
                XCTFail("We shouldn't fail as a term was saved")
                mockDefaults.removeObject(forKey: Constants.UserDefaultsIdentifiers.favouriteLocations.id)
            }
        }
        
        mockDefaultsManager.save(mockWeatherRequest)
        mockDefaultsManager.retriveObjectsFor(key: Constants.UserDefaultsIdentifiers.favouriteLocations.id)
    }

}


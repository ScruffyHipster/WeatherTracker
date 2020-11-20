//
//  HomeViewModel.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import UIKit

/// View model for the home view
class HomeViewModel {
    
    // MARK: - Properties
    private var homeViewTableViewDataSource: HomeViewTableViewDataSource
    private var weatherResultsManager: WeatherResultsManager<WeatherRequest>
    
    // MARK: - Lifecycle methods
    init(homeViewTableViewDataSource: HomeViewTableViewDataSource = HomeViewTableViewDataSource(),
         resultsManager: WeatherResultsManager<WeatherRequest> = WeatherResultsManager<WeatherRequest>()) {
        self.homeViewTableViewDataSource = homeViewTableViewDataSource
        self.weatherResultsManager = resultsManager
        setUpResultsHandler()
    }
    
    /// Handles the setup of the weather results data handler
    private func setUpResultsHandler() {
        weatherResultsManager.resultsHandler = { result in
            switch result {
            case .success(let response):
                //show the results in a modal
                print(response)
            case .failure(let error):
                //TODO: Handle error response
                print(error)
            }
        }
    }
    
    /// Initiate a search for weather results
    /// - Parameter city: city to search results for
    func search(for city: String) {
        weatherResultsManager.search(endpoint: .weather(city))
    }
    
}


/// Table view data source for the home view table view
class HomeViewTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var favourtieLocations = [String]()
    
    // MARK: - Table view data souce
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return favourtieLocations.count
        default:
            fatalError("There should only be two sections maximum")
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleLabel = UILabel()
        switch section {
        case 0:
            titleLabel.text = "Current location"
        case 1:
            titleLabel.text = "Favourite locations"
        default:
            break
        }
        return titleLabel
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    
    
}

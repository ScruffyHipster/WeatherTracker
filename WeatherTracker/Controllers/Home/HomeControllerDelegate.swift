//
//  HomeControllerDelegate.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import UIKit

/// Delegate for the home view controller
protocol HomeControllerDataSourceDelegate: class {
    
    func gotInitalLocationWeather(_ result: WeatherRequest)
    func didGetResult(_ result: WeatherRequest)
    
}


/// Data source and delgate for the home view controller.
class HomeViewControllerDataSource: NSObject, UISearchResultsUpdating {
    
    //MARK: - Outlets
    private var searchResultsManager: WeatherResultsManager<WeatherRequest>
    
    weak var delegate: HomeControllerDataSourceDelegate?
    
    // MARK: - Lifecycle
    init(searchResultsManager: WeatherResultsManager<WeatherRequest> = WeatherResultsManager<WeatherRequest>()) {
        self.searchResultsManager = searchResultsManager
        super.init()
        setUpResultsHandler()
    }
    
    //MARK: - Methods
    
    private func getInitalLocationData() {
        
    }

    
    private func setUpResultsHandler() {
        searchResultsManager.resultsHandler = { [weak self] in
            guard let self = self else { return }
            switch $0 {
            case .success(let result):
                print(result)
                self.delegate?.didGetResult(result)
                //display the results to the user
            case .failure(let error):
                //show an error that no results we're found
                print(error.errorDescription)
            }
        }
    }
    
}

extension HomeViewControllerDataSource: UISearchBarDelegate {
  
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResultsManager.search(endpoint: .weather(searchBar.text ?? ""))
        
    }
    
    //MARK: - Search results delegate
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        //store the result of the user input and call debounce
        searchResultsManager.search(endpoint: .weather(text))
    }
    
}

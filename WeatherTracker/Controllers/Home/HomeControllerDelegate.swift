//
//  HomeControllerDelegate.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import UIKit

/// Delegate for the home view controller
protocol HomeControllerDelegate: class, UISearchResultsUpdating {
    
    
    
}

/// Data source for the home view controller
class HomeViewControllerDataSource: NSObject, HomeControllerDelegate {
    
    //MARK: - Outlets
    private var searchResultsManager: WeatherResultsManager<WeatherRequest>
    private var debounce: Debounce
    
    private var searchText: String?
    
    // MARK: - Lifecycle
    init(debounce: Debounce = Debounce(),
         searchResultsManager: WeatherResultsManager<WeatherRequest> = WeatherResultsManager<WeatherRequest>()) {
        self.debounce = debounce
        self.searchResultsManager = searchResultsManager
    }
    
    //MARK: - Methods
    private func setUpDebounce() {
        debounce.handler = { [weak self] in
            //whenever debounce.call() is made this will fire
            guard let self = self,
                  let text = self.searchText else { return }
            self.searchResultsManager.search(endpoint: .weather(text))
        }
    }
    
    private func setUpResultsHanlder() {
        searchResultsManager.resultsHandler = { [weak self] in
            switch $0 {
            case .success(let result):
                print(result)
                //display the results to the user
            case .failure(let error):
                //show an error that no results we're found
                print(error.errorDescription)
            }
        }
    }
    
}

extension HomeViewControllerDataSource {
    
    //MARK: - Search results delegate
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        //store the result of the user input and call debounce
        searchText = text
        debounce.call()
    }
    
}

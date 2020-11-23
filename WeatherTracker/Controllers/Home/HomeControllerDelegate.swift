//
//  HomeControllerDelegate.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import UIKit


/// Data source and delgate for the home view controller.
final class HomeViewControllerDataSource: NSObject, UISearchResultsUpdating {
    
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
                let errorAlert = UIAlertController.createError(body: error.errorDescription ?? "")
                self.delegate?.presentError(errorAlert)
            }
        }
    }
    
}

// MARK:  Search bar delegate
extension HomeViewControllerDataSource: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResultsManager.search(endpoint: .weather(searchBar.text ?? ""))
    }
    
    //MARK: - Search results delegate
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchResultsManager.search(endpoint: .weather(text))
    }
    
}

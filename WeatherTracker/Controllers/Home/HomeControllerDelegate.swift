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
    
    
    
}

extension HomeViewControllerDataSource {
    
    //MARK: - Search results delegate
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
    
}

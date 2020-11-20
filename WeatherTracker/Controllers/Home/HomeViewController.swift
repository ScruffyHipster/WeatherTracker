//
//  HomeViewController.swift
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

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var homeView: HomeView!
    
    // MARK: - Properties
    weak var coordinator: Coordinator?
    var homeViewModel: HomeViewModel?
    var homeControllerDataSource: HomeViewControllerDataSource?
    
    private var searchController: UISearchController?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHomeView()
    }
    
    private func setupHomeView() {
        guard let homeViewModel = homeViewModel else { return }
        homeView.homeViewModel = homeViewModel
        homeView.tableView.delegate = homeViewModel.homeViewTableViewDataSource
        homeView.tableView.dataSource = homeViewModel.homeViewTableViewDataSource
        setUpSearchBar()
    }
    
    private func setUpSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = homeControllerDataSource
        searchController?.obscuresBackgroundDuringPresentation = true
        searchController?.searchBar.placeholder = "Search for a location"
        navigationItem.searchController = searchController
    }

}

extension HomeViewController: HomeControllerDataSourceDelegate {
    
    /// Handles the results oi user location request
    /// - Parameter result: the result of the users location
    func gotInitalLocationWeather(_ result: WeatherRequest) {
        print(result)
    }
    
    /// Handles the result call back from the user search
    /// - Parameter result: the weather  result
    func didGetResult(_ result: WeatherRequest) {
        //we can move to show this on the details view
    }
    
    
}

// MARK: - Storyboarded extension
extension HomeViewController: Storyboarded {
    static var storyboardId: StoryboardIdentifiers { .main }
}

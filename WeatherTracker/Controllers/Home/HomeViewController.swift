//
//  HomeViewController.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var homeView: HomeView!
    
    // MARK: - Properties
    weak var coordinator: HomeCoordinator?
    var homeViewModel: HomeViewModel?
    var homeControllerDataSource: HomeViewControllerDataSource?
    
    private var searchController: UISearchController?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpController()
    }
    
    /// Sets up the UI elements and their data models
    private func setUpController() {
        homeControllerDataSource?.delegate = self
        setUpHomeViewModel()
        setUpHomeView()
        setUpSearchBar()
    }
    
    private func setUpHomeViewModel() {
        guard let homeViewModel = homeViewModel else { return }
        homeViewModel.homeViewTableView = homeView.tableView
        homeViewModel.setUp()
    }
    
    private func setUpHomeView() {
        guard let homeViewModel = homeViewModel else { return }
        homeView.tableView.delegate = homeViewModel.homeViewTableViewDataSource
        homeView.tableView.dataSource = homeViewModel.homeViewTableViewDataSource
        homeView.tableView.register(HomeTableViewSectionHeader.nib, forHeaderFooterViewReuseIdentifier: HomeTableViewSectionHeader.reuseIdentifier)
    }
    
    private func setUpSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchBar.delegate = homeControllerDataSource
        searchController?.obscuresBackgroundDuringPresentation = true
        searchController?.searchBar.placeholder = "Search for a location"
        navigationItem.searchController = searchController
    }

}

// MARK: - Home controller data source delegate
extension HomeViewController: HomeControllerDataSourceDelegate {
    
    /// Handles the results oi user location request
    /// - Parameter result: the result of the users location
    func gotInitalLocationWeather(_ result: WeatherRequest) {
        print(result)
        //show this result in a results field table view
        //for the user to select from
        
        //TODO:- we may need to get rid of this ⚠️
    }
    
    /// Handles the result call back from the user search
    /// - Parameter result: the weather  result
    func didGetResult(_ result: WeatherRequest) {
        //we can move to show this on the details view
        print(result)
        //make call to the coordinator for the next view
        coordinator?.showDetailsViewWith(result)
    }
    
    
}

// MARK: - Storyboarded extension
extension HomeViewController: Storyboarded {
    static var storyboardId: StoryboardIdentifiers { .main }
}

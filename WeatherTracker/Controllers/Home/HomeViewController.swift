//
//  HomeViewController.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import UIKit

/// Handles the home view and communication with the coordinator
final class HomeViewController: UIViewController {
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.syncUpUserDefaults()
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
        homeViewModel.delegate = self
        homeViewModel.setUp()
    }
    
    private func setUpHomeView() {
        guard let homeViewModel = homeViewModel else { return }
        homeView.tableView.delegate = homeViewModel
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
    
    /// Present the alert error
    /// - Parameter error: alert error to show to user
    func presentError(_ error: UIAlertController) {
        present(error, animated: true)
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

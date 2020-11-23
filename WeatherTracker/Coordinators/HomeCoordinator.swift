//
//  HomeCoordinator.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import UIKit

//Handles the navigation and data pass through between main view
//and details view. Provides the view controllers with its view controllers
//and datasources leaving the VC's to handle only what they need to be concerned with
//data calls and view layout for example.
final class HomeCoordinator: Coordinator {
    
    //MARK: - Properties
    var children: [Coordinator]?
    
    var navigationController: UINavigationController
    
    private var homeControllerDataSource: HomeViewControllerDataSource
    private var homeViewModel: HomeViewModel
    private var notification: NotificationCenter
    private var detailsViewModel: DetailsViewModel?
    private var userDefaults: WeatherUserDefaultsManager?
    private var locationManager: LocationManager?
    private var userDefaultsKey: String {
        Constants.UserDefaultsIdentifiers.favouriteLocations.id
    }
    
    lazy var homeController: HomeViewController = {
        var controller = HomeViewController.instantiate()
        controller.coordinator = self
        controller.homeControllerDataSource = homeControllerDataSource
        controller.homeViewModel = homeViewModel
        return controller
    }()
    var detailsController: DetailsViewController?
    
    //MARK: - Life cycle methods
    init(navController: UINavigationController,
         homeControllerDataSource: HomeViewControllerDataSource = HomeViewControllerDataSource(),
         homeViewModel: HomeViewModel = HomeViewModel(),
         userDefaults: WeatherUserDefaultsManager = WeatherUserDefaultsManager(userDefaults: .standard),
         notification: NotificationCenter = NotificationCenter.default) {
        self.notification = notification
        self.navigationController = navController
        self.homeControllerDataSource = homeControllerDataSource
        self.homeViewModel = homeViewModel
        self.userDefaults = userDefaults
    }
    
    //MARK: - Methods
    func start() {
        setUpUserDefaults()
        setUpNotificationManager()
        setUpLocationManager()
        setUpNavbar()
        initHomeViewController()
    }
    
    // MARK:  VC init methods

    /// Sets up the inital home view controller
    private func initHomeViewController() {
        navigationController.pushViewController(homeController, animated: true)
    }
    
    /// Init the details view controller
    /// - Parameter result: weather result to present
    private func initDetailsViewController(with result: WeatherRequest) {
        detailsController = DetailsViewController.instantiate()
        detailsController?.coordinator = self
        setUpDetailsViewModel()
        //check if in favourties and set whether favourtied
        
        let isFavourite = homeViewModel.favouriteLocations.filter({
            $0.name == result.name
        })
        detailsController?.viewModel?.isFavourite = isFavourite.count == 1
        
        detailsController?.weatherResponse = result
        guard let detailsController = detailsController else { return }
        self.navigationController.present(detailsController, animated: true)
    }
    
    /// setup the details view model to pass to the details vc
    private func setUpDetailsViewModel() {
        detailsViewModel = DetailsViewModel()
        guard let detailsViewModel = detailsViewModel else { return }
        detailsController?.viewModel = detailsViewModel
    }
    
    /// Sets up the location manager used to get users current location
    private func setUpLocationManager() {
        locationManager = LocationManager()
        
        locationManager?.handler = { [weak self] location, error in
            guard let self = self,
                  let location = location else {
                //show the error to the user if applicable
                return
            }
            //set the current location
            self.homeViewModel.currentLocation = location.locality
        }
        
        locationManager?.start()
    }
    
    private func setUpNavbar() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.backgroundColor = .white
    }
    
    /// Sets up the notifications manager
    private func setUpNotificationManager() {
        notification.addObserver(forName: .selectedFavouriteDetailsCell,
                                 object: nil,
                                 queue: .main) { [weak self] (notification) in
            guard let self = self,
                  let userInfo = notification.userInfo,
                  let indexPath = userInfo[Constants.NotificationDictKeys.selectedCell.id] as? IndexPath else {return}
            //we have the index so now we can find it in the
            //table view data souce
            self.initDetailsViewController(with: self.homeViewModel.favouriteLocations[indexPath.row])
            
        }
    }
    
    /// Sets up the user defaults for data persistence
    private func setUpUserDefaults() {
        userDefaults?.defaultsReturnDataHandler = { [weak self] (results, error) in
            //search the user defaults for favourite
            //locations and present to the view controller for
            //data handling on launch and periodically check for new ones.
            guard let error = error else {
                guard let results = results,
                      let self = self
                else { return }
                self.homeViewModel.favouriteLocations = results
                return
            }
            let errorAlert = UIAlertController.createError(body: error.localizedDescription)
            self?.homeController.present(errorAlert, animated: true)
        }
    }
    
}

// MARK:  HomeViewController coordinator methods
extension HomeCoordinator {
    
    /// Sets up the user defaults used for persistence
    func syncUpUserDefaults() {
        userDefaults?.retriveObjectsFor(key: Constants.UserDefaultsIdentifiers.favouriteLocations.id)
    }
    
    /// Prepare the details view
    /// - Parameter data: the data to be presented
    func showDetailsViewWith(_ data: WeatherRequest) {
        initDetailsViewController(with: data)
    }
    
    /// Handle selecting a location to save
    /// - Parameters:
    ///   - favourite: whether this is to save or remove
    ///   - data: this particular location
    func didFavouriteWeatherLocation(_ favourite: Bool, _ data: WeatherRequest) {
        //we need to store the weather request in user defaults
        if favourite {
            userDefaults?.save(data)
        } else {
            userDefaults?.deleteObject(object: data, key: userDefaultsKey)
        }
        userDefaults?.retriveObjectsFor(key: userDefaultsKey)
    }
    
}

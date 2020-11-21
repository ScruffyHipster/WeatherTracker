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
class HomeCoordinator: Coordinator {
    
    //MARK: - Properties
    var children: [Coordinator]?
    
    var navigationController: UINavigationController
    
    private var homeControllerDataSource: HomeViewControllerDataSource
    private var homeViewModel: HomeViewModel
    private var userDefaults: WeatherUserDefaultsManager?
    private var locationManager: LocationManager?
    
    lazy var homeController: HomeViewController = {
        var controller = HomeViewController.instantiate()
        controller.coordinator = self
        controller.homeViewModel = homeViewModel
        return controller
    }()
    
    //MARK: - Life cycle methods
    init(navController: UINavigationController,
         homeControllerDataSource: HomeViewControllerDataSource = HomeViewControllerDataSource(),
         homeViewModel: HomeViewModel = HomeViewModel(),
         userDefaults: WeatherUserDefaultsManager = WeatherUserDefaultsManager(userDefaults: .standard) { (results, error) in

            //search the user defaults for favourite
            //locations and present to the view controller for
            //data handling on launch and periodically check for new ones.
            
            
         }) {
        self.navigationController = navController
        self.homeControllerDataSource = homeControllerDataSource
        self.homeViewModel = homeViewModel
    }
    
    //MARK: - Methods
    func start() {
        setUpUserDefaults()
        setUpLocationManager()
        initHomeViewController()
    }
    
    private func initHomeViewController() {
        navigationController.pushViewController(homeController, animated: true)
    }
    
    private func setUpUserDefaults() {
        userDefaults?.retriveObjectsFor(key: Constants.UserDefaultsIdentifiers.favouriteLocations.id)
    }
    
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
    
    
}

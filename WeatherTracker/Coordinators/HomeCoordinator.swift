//
//  HomeCoordinator.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import UIKit

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
            
            //do something with the results
            
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

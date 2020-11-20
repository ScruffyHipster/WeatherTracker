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
    
    private var homeControllerDataSource: HomeControllerDelegate
    private var homeViewModel: HomeViewModel
    private var userDefaults: WeatherUserDefaultsManager?
    
    lazy var homeController: HomeViewController = {
        var controller = HomeViewController.instantiate()
        controller.delegate = homeControllerDataSource
        controller.homeViewModel = homeViewModel
        return controller
    }()
    
    //MARK: - Life cycle methods
    init(navController: UINavigationController,
         homeControllerDataSource: HomeControllerDelegate = HomeViewControllerDataSource(),
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
        initHomeViewController()
    }
    
    private func initHomeViewController() {
        
        navigationController.pushViewController(homeController, animated: true)
    }
    
    private func setUpUserDefaults() {
        userDefaults?.retriveObjectsFor(key: Constants.UserDefaultsIdentifiers.favouriteLocations.id)
    }
    
    
}

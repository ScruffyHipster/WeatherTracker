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
    
    lazy var homeController: HomeViewController = {
        var controller = HomeViewController.instantiate()
        controller.delegate = homeControllerDataSource
        controller.homeViewModel = homeViewModel
        return controller
    }()
    
    //MARK: - Life cycle methods
    init(navController: UINavigationController,
         homeControllerDataSource: HomeControllerDelegate = HomeViewControllerDataSource(),
         homeViewModel: HomeViewModel = HomeViewModel()) {
        self.navigationController = navController
        self.homeControllerDataSource = homeControllerDataSource
        self.homeViewModel = homeViewModel
    }
    
    //MARK: - Methods
    func start() {
        //do something
    }
    
    private func initHomeViewController() {
        navigationController.present(homeController, animated: true)
    }
    
    
}

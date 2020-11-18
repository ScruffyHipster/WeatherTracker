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
    weak var delegate: HomeControllerDelegate?
    
    var homeViewModel: HomeViewModel?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHomeView()
    }
    
    private func setupHomeView() {
        homeView.homeViewModel = homeViewModel
    }

}

// MARK: - Storyboarded extension
extension HomeViewController: Storyboarded {
    static var storyboardId: StoryboardIdentifiers { .main }
}

//
//  DetailsViewController.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 22/11/2020.
//

import UIKit

/// Hnadles the details view and the models required
final class DetailsViewController: UIViewController {
    
    // MARK:  Outlets
    @IBOutlet weak var detailsView: DetailsView!
    
    // MARK:  Properties
    weak var coordinator: HomeCoordinator?
    weak var viewModel: DetailsViewModel?
    var weatherResponse: WeatherRequest?
    
    // MARK:  Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK:  Methods
    private func setUp() {
        viewModel?.weatherRequestResult = weatherResponse
        viewModel?.detailsView = detailsView
        viewModel?.setUpView()
    }
    
    // MARK:  Actions
    @IBAction func didTapFavouriteButton(_ sender: Any) {
        //set the heart icon to filled
        viewModel?.didToggleFavouriteButton()
        guard let weatherResponse = weatherResponse else { return }
        coordinator?.didFavouriteWeatherLocation(viewModel?.isFavourite ?? false, weatherResponse)
    }
    
}

// MARK:  Storyborded
extension DetailsViewController: Storyboarded {
    static var storyboardId: StoryboardIdentifiers { .main }
}

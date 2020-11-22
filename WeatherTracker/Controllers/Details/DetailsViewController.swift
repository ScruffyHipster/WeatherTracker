//
//  DetailsViewController.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 22/11/2020.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var detailsView: DetailsView!
    
    weak var coordinator: HomeCoordinator?
    var viewModel: DetailsViewModel!
    var weatherResponse: WeatherRequest?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }
    
    private func setUp() {
        viewModel.weatherRequestResult = weatherResponse
        viewModel.detailsView = detailsView
        viewModel.setUpView()
    }
    
 
    @IBAction func didTapFavouriteButton(_ sender: Any) {
        print("favourite \(weatherResponse)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailsViewController: Storyboarded {
    static var storyboardId: StoryboardIdentifiers { .main }
}

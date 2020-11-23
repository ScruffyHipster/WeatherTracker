//
//  DetailsViewModel.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 22/11/2020.
//

import UIKit

/// Hnadles configuring the data for presentation on the details view
final class DetailsViewModel {
    
    // MARK:  Properties
    weak var detailsView: DetailsView?
    var weatherRequestResult: WeatherRequest?
    var isFavourite = false
    
    lazy var numberFormatter: NumberFormatter = { NumberFormatter() }()
    
    // MARK:  Methods
    func setUpView() {
        guard let detailsView = detailsView,
              let weatherResult = weatherRequestResult
        else {
            fatalError("There should be a details view and result present")
        }
        configure(view: detailsView, with: weatherResult)
    }
    
    private func configure(view: DetailsView, with data: WeatherRequest) {
        toggleFavouriteButton(isFavourite)
        view.detailsImageView.image = #imageLiteral(resourceName: "mountainImage")
        view.locationDetailsLabel.text = data.name
        view.countryLabel.text = data.sys.country
        view.conditionsLabel.text = data.weather.first?.weatherDescription
        view.tempLabel.text = numberFormatter.string(from: NSNumber(value: data.main.temp))
        view.windSpeedLabel.text = numberFormatter.string(from: NSNumber(value: data.wind.speed))?.appending(" mph")
        view.windDirectionImageView.getWindDirectionImage(from: data.wind.deg)
    }
    
    func didToggleFavouriteButton() {
        //set weather request result to opposite of current
        //favourite state
        isFavourite = !isFavourite
        toggleFavouriteButton(isFavourite)
    }
    
    private func toggleFavouriteButton(_ favourited: Bool) {
        detailsView?.favouriteButton.setImage(UIImage(systemName: favourited ? "heart.fill" : "heart"), for: .normal)
    }
    
}

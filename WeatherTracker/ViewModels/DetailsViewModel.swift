//
//  DetailsViewModel.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 22/11/2020.
//

import UIKit

class DetailsViewModel {
    
    var detailsView: DetailsView!
    var weatherRequestResult: WeatherRequest?
    var isFavourtie = false
    
    lazy var numberFormatter: NumberFormatter = { NumberFormatter() }()
    
    func setUpView() {
        guard let detailsView = detailsView,
              let weatherResult = weatherRequestResult
        else {
            fatalError("There should be a details view and result present")
        }
        configure(view: detailsView, with: weatherResult)
    }
    
    private func configure(view: DetailsView, with data: WeatherRequest) {
        toggleFavouriteButton(isFavourtie)
        view.locationDetailsLabel.text = data.name
        view.countryLabel.text = data.sys.country
        view.conditionsLabel.text = data.weather.first?.weatherDescription
        view.tempLabel.text = numberFormatter.string(from: NSNumber(value: data.main.temp))
        view.windSpeedLabel.text = numberFormatter.string(from: NSNumber(value: data.wind.speed))?.appending(" mph")
    }
    
    func didToggleFavouriteButton() {
        //set weather request result to opposite of current
        //favourite state
        isFavourtie = !isFavourtie
        toggleFavouriteButton(isFavourtie)
    }
    
    private func toggleFavouriteButton(_ favourited: Bool) {
        detailsView?.favouriteButton.setImage(UIImage(systemName: favourited ? "heart.fill" : "heart"), for: .normal)
    }
    
}

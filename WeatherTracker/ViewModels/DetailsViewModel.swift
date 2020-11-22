//
//  DetailsViewModel.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 22/11/2020.
//

import Foundation

class DetailsViewModel {
    
    var detailsView: DetailsView?
    var weatherRequestResult: WeatherRequest?
    
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
        view.locationDetailsLabel.text = data.name
        view.countryLabel.text = data.sys.country
        view.tempLabel.text = numberFormatter.string(from: NSNumber(value: data.main.temp))
        view.windSpeedLabel.text = numberFormatter.string(from: NSNumber(value: data.wind.speed))
    }
    
    
}

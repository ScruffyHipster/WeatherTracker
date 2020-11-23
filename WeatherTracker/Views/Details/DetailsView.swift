//
//  DetailsView.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 22/11/2020.
//

import UIKit

// The view for the details view controller
final class DetailsView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var locationDetailsLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionImageView: UIImageView!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        buttonContainerView.addCornerRadiusOf(favouriteButton.frame.width / 2)
        buttonContainerView.addShadowLayer(colour: .gray, radius: 6, offset: .init(width: 0, height: 2), opacity: 0.8)
    }
    
}

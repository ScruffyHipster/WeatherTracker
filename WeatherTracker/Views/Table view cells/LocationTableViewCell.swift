//
//  LocationTableViewCell.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 18/11/2020.
//

import UIKit

/// Cell which displays a location
final class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundContentView: UIView!
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var tempDegreesLabel: UILabel!
    @IBOutlet weak var windDirectionImage: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        backgroundImageView.addCornerRadiusOf(12)
        backgroundContentView.addCornerRadiusOf(12)
        backgroundContentView.addShadowLayer(colour: .black, radius: 2, offset: .init(width: 0, height: 2), opacity: 1)
    }
    
}

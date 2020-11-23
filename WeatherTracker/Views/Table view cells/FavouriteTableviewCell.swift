//
//  FavouriteTableviewCell.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 23/11/2020.
//

import UIKit

/// Cell which displays a favourite location
final class FavouriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundContentView: UIView!
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
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

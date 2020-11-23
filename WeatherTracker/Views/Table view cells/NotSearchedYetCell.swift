//
//  NotSearchedYetCell.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 20/11/2020.
//

import UIKit

/// Cell which provides information on how to use the app
final class NotSearchedYetCell: UITableViewCell {
    
    @IBOutlet weak var infoLable: UILabel!
    @IBOutlet weak var windImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setUpView() {
        backgroundContentView.addCornerRadiusOf(12)
        backgroundContentView.addShadowLayer(colour: .black, radius: 2, offset: .init(width: 0, height: 2), opacity: 1)
    }
    
}

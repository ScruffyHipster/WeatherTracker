//
//  File.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 21/11/2020.
//

import UIKit

/// header for the table view sections
final class HomeTableViewSectionHeader: UITableViewHeaderFooterView {
    
    //MARK: - Outlets 
    @IBOutlet weak var sectionHeaderLabel: UILabel!
    @IBOutlet weak var sectionImageView: UIImageView!
    
    static let reuseIdentifier: String = String(describing: self)
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
}

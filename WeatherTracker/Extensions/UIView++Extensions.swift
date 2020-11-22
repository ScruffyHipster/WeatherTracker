//
//  UIView++Extensions.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 20/11/2020.
//

import UIKit

extension UIView {

    /// Adds corner radius
    /// - Parameters:
    ///   - radius: the desired corner radius
    ///   - corners: corners to mask
    func addCornerRadiusOf(_ radius: CGFloat, corners: CACornerMask? = nil) {
        guard let corners = corners else {
            self.layer.cornerRadius = radius
            return
        }
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }

    /// Add shadow layer to the view that calls this function
    /// - Parameter colour: Color of the shadow
    /// - Parameter radius: radius of the shadow from the view
    /// - Parameter offset: offset of the shadow
    /// - Parameter opacity: opacity of the shadow
    func addShadowLayer(colour: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) {
        self.layer.shadowColor = colour.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
    }
    
}

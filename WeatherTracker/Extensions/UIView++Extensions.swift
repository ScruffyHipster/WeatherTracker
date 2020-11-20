//
//  UIView++Extensions.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 20/11/2020.
//

import UIKit

extension UIView {

    /// Loads view nib when called on a view type if it exists
    /// - Returns: a view
    static func loadFromNib() -> UIView? {
        guard let nibView = Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil) else {
            return nil
        }
        return nibView.first as? UIView
    }

    /// Adds a view and provides closure for further actions
    /// - Parameters:
    ///   - view: view to add
    ///   - then: closure with passed in view
    func add(_ view: UIView, then: ((UIView) -> Void)) {
        self.addSubview(view)
        then(view)
    }

    /// Helper method to add constraints to views quickly, this also applies the translatesAutoResizingMask for convienece
    ///
    /// - Parameters:
    ///   - top: top anchor of superview
    ///   - trailing: trailing anchor of superview
    ///   - bottom: bottom anchor of superview
    ///   - leading: leading anchor of superview
    ///   - padding: padding from superview
    ///   - size: size of view
    func anchor(top: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }

    }

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

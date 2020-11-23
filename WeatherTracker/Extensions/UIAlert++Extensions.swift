//
//  UIAlert++Extensions.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 23/11/2020.
//

import UIKit

extension UIAlertController {
    
    /// Creates and returns an alert with the confirgured actions
    /// - Parameters:
    ///   - style: alert or sheet
    ///   - title: the title to display
    ///   - body: body content
    ///   - actions: array of actions
    /// - Returns: alert for presentation
    static func createAlert(style: UIAlertController.Style,
                            title: String,
                            body: String,
                            actions: [UIAlertAction]? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: body, preferredStyle: style)
        guard let actions = actions else {
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            return alert
        }
        actions.forEach({alert.addAction($0)})
        return alert
    }
    
    /// Creates and returns an error alert with the confirgured actions
    /// - Parameters:
    ///   - style: alert or sheet
    ///   - title: the title to display
    ///   - body: body content
    ///   - actions: array of actions
    /// - Returns: alert for presentation
    static func createError(style: UIAlertController.Style = .alert,
                            title: String = "Whoops an Error Occured",
                            body: String,
                            actions: [UIAlertAction]? = nil) -> UIAlertController {
        return self.createAlert(style: style, title: title, body: body, actions: actions)
    }
}

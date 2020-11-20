//
//  Debouncer.swift
//  WeatherTracker
//
//  Created by Thomas Murray on 20/11/2020.
//

import Foundation

/// Provides debounce support for user input
final class Debounce: DebounceProtocol {

    // MARK: - Properties
    internal var timer: Timer?
    internal var delay: TimeInterval
    var handler: (() -> ())?


    //MARK: - Life cycle
    /// - Parameter delay: delay
    init(delay: TimeInterval = 0.2) {
        self.delay = delay
    }

    deinit {
        timer?.invalidate()
    }
    
    // MARK: - Methods
    /// calls the handler based on timer
    func call() {
        DispatchQueue.main.async {
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: self.delay, target: self, selector: #selector(self.callBack), userInfo: nil, repeats: false)
        }
    }

    @objc private func callBack() {
        handler?()
    }

}

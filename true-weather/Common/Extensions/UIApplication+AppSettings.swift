//
//  UIApplication+AppSettings.swift
//  true-weather
//
//  Created by Alex on 11.02.2024.
//

import UIKit

public extension UIApplication {
    func openAppSettings() {
        if let url = URL.init(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

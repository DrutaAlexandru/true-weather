//
//  true_weatherApp.swift
//  true-weather
//
//  Created by Alex on 09.02.2024.
//

import SwiftUI

@main
struct true_weatherApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

//
//  RootViewModel.swift
//  true-weather
//
//  Created by Alex on 11.02.2024.
//

import Foundation

class RootViewModel: ObservableObject {
        
    func checkForCachedDataAvailable() -> Bool {
        !UserDefaultsManager.shared.getCitiesList().isEmpty
    }
    
    func checkForLocationAvailability() -> Bool {
        LocationManager.shared.checkPermissionStatus() == .allowed
    }
    
}

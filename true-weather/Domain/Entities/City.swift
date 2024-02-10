//
//  City.swift
//  true-weather
//
//  Created by Alex on 09.02.2024.
//

import Foundation

struct City: Identifiable {
    let id: Int
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double
    
    var detailedName: String {
        name + ", " + country
    }
    
    var coordinates: Coordinates {
        Coordinates(latitude: latitude, longitude: longitude)
    }
}

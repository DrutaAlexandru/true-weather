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

#if DEBUG
extension City {
    static let mock = City(id: 618426,
                           name: "Chisinau",
                           country: "Moldova",
                           latitude: 47.00556,
                           longitude: 28.8575)
}
#endif

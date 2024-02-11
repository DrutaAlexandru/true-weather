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
    var latitude: Double
    var longitude: Double
    
    var detailedName: String {
        name + ", " + country
    }
    
    var coordinates: Coordinates {
        Coordinates(latitude: latitude, longitude: longitude)
    }
}

extension City: Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
}

extension City {
    static let currentLocation = City(id: 0,
                                      name: "Current Location",
                                      country: "",
                                      latitude: 0,
                                      longitude: 0)
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

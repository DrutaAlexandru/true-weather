//
//  APIEndpoints.swift
//  true-weather
//
//  Created by Alex on 10.02.2024.
//

import Foundation

enum APIEndpoints: String {
    case weather        = "https://api.open-meteo.com/v1/forecast"
    case autocomplete   = "https://geocoding-api.open-meteo.com/v1/search"
}

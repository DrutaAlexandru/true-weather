//
//  FetchWeatherUseCase.swift
//  true-weather
//
//  Created by Alex on 10.02.2024.
//

import Foundation

protocol FetchWeatherUseCase {
    func getWeather(for coordinates: Coordinates) async throws -> Weather
}

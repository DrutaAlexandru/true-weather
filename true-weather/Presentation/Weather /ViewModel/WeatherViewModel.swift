//
//  WeatherViewModel.swift
//  true-weather
//
//  Created by Alex on 10.02.2024.
//

import Foundation
import Combine
import SwiftUI

class WeatherViewModel: ObservableObject {
    
    @Published var city: City
    @Published var isLoading: Bool
    @Published var weatherData: Weather?
    
    var isDataDownloaded: Bool
    
    var showErrorPublisher = PassthroughSubject<String, Never>()
    var showCitiesListPublisher = PassthroughSubject<Void, Never>()
    
    init(city: City) {
        isLoading = false
        isDataDownloaded = false
        weatherData = nil
        self.city = city
    }
    
    init() {
        isLoading = false
        isDataDownloaded = false
        weatherData = nil
        self.city = .init(id: 0, name: "", country: "", latitude: 0, longitude: 0)
    }
    
    func setCity(city: City) {
        self.city = city
        loadData(force: true)
    }
    
    func loadData(force: Bool = false) {
        guard !isDataDownloaded || force else { return }
        Task {
            do {
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading = true
                }
                
                let data: Weather
                if city.id == 0 {
                    let location = try await LocationManager.shared.getCurrentLocation()
                    DispatchQueue.main.async { [weak self] in
                        self?.city.latitude = location.coordinate.latitude
                        self?.city.longitude = location.coordinate.longitude
                    }
                    data = try await APIFetchWeatherUseCase().getWeather(for: Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                } else {
                    data = try await APIFetchWeatherUseCase().getWeather(for: city.coordinates)
                }
                
                print(data)
                
                DispatchQueue.main.async { [weak self] in
                    withAnimation {
                        self?.weatherData = data
                        self?.isLoading = false
                        self?.isDataDownloaded = true
                    }
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    withAnimation {
                        self?.isLoading = false
                    }
                    if error is JSONParsingError {
                        self?.showErrorPublisher.send("Found an error while parsing JSON Response")
                    }
                    if let networkError = error as? NetworkError {
                        switch networkError {
                        case .invalidRequest:
                            self?.showErrorPublisher.send("Invalid request")
                        case .invalidResponse:
                            self?.showErrorPublisher.send("Received and invalid response")
                        case .timeout:
                            self?.showErrorPublisher.send("Request timeout")
                        case .error(let string):
                            self?.showErrorPublisher.send(string)
                        }
                    }
                    if error is LocationUnavaliable {
                        self?.showErrorPublisher.send("Could not detect your location, please try again")
                    }
                }
            }
        }
    }
    
    func showCitiesList() {
        showCitiesListPublisher.send()
    }
}

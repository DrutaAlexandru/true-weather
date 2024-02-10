//
//  WeatherViewModel.swift
//  true-weather
//
//  Created by Alex on 10.02.2024.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    private var coordinates: Coordinates
    
    @Published var isLoading: Bool
    
    @Published var weatherData: Weather?
    
    var isDataDownloaded: Bool
    
    var showErrorPublisher = PassthroughSubject<String, Error>()
    
    init(coordinates: Coordinates) {
        isLoading = false
        isDataDownloaded = false
        weatherData = nil
        self.coordinates = coordinates
    }
    
    func loadData() {
        guard !isDataDownloaded else { return }
        Task {
            do {
                isLoading = true
                let data = try await APIFetchWeatherUseCase().getWeather(for: coordinates)
                print(data)
                DispatchQueue.main.async { [weak self] in
                    self?.weatherData = data
                    self?.isLoading = false
                    self?.isDataDownloaded = true
                }
            } catch {
                isLoading = false
                // Check Error value
                showErrorPublisher.send("")
            }
        }
    }
}

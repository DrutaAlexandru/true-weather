//
//  CitiesListViewModel.swift
//  true-weather
//
//  Created by Alex on 10.02.2024.
//

import Foundation
import Combine

class CitiesListViewModel: ObservableObject {
    
    private var cachedCitiesList: [City]
    
    @Published var selectedCity: City?
    
    @Published var isLoading: Bool
    @Published var cities: [City] {
        didSet {
            if searchText.isEmpty {
                cachedCitiesList = cities.filter({ $0.id != 0 })
                UserDefaultsManager.shared.setCitiesList(cachedCitiesList)
                if cachedCitiesList.isEmpty { UserDefaultsManager.shared.setSelectedCity(nil) }
            }
        }
    }
    
    @Published var searchText: String {
        didSet {
            if searchText.isEmpty {
                cities = visibleCachedCitiesList
            }
        }
    }
    
    var trimmedSearchText: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var visibleCachedCitiesList: [City] {
        if LocationManager.shared.checkPermissionStatus() == .allowed {
            [City.currentLocation] + cachedCitiesList.filter({ $0.id != 0 })
        } else {
            cachedCitiesList.filter({ $0.id != 0 })
        }
    }
    
    var didSelectCityPublisher = PassthroughSubject<City, Never>()
    var showErrorPublisher = PassthroughSubject<String, Never>()
    
    init() {
        isLoading = false
        cachedCitiesList = []
        cities = []
        searchText = ""
        
        parseSavedCities()
    }
    
    func parseSavedCities() {
        cachedCitiesList = UserDefaultsManager.shared.getCitiesList()
        cities = visibleCachedCitiesList
        selectedCity = UserDefaultsManager.shared.getSelectedCity() ?? City.currentLocation
    }
    
    func selectCity(_ city: City) {
        selectedCity = city
        didSelectCityPublisher.send(city)
        searchText = ""
        UserDefaultsManager.shared.setSelectedCity(city)
        if !cachedCitiesList.contains(city) {
            cachedCitiesList.append(city)
            UserDefaultsManager.shared.setCitiesList(cachedCitiesList)
        }
    }
    
    func fetchAutocompleteValues() {
        Task {
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = true
            }
            let autocompleteCities = try await APISearchCityUseCase().fetchResults(with: trimmedSearchText)
            
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
                self?.cities = autocompleteCities
            }
        }
    }
}

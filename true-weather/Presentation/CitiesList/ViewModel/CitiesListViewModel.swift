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
                cachedCitiesList = cities
                UserDefaultsManager.shared.setCitiesList(cachedCitiesList)
            }
        }
    }
    
    @Published var searchText: String {
        didSet {
            if searchText.isEmpty {
                cities = cachedCitiesList
            }
        }
    }
    
    var trimmedSearchText: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
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
        cities = UserDefaultsManager.shared.getCitiesList()
        selectedCity = UserDefaultsManager.shared.getSelectedCity()
    }
    
    func selectCity(_ city: City) {
        selectedCity = city
        didSelectCityPublisher.send(city)
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

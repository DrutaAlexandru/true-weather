//
//  CitiesListViewModel.swift
//  true-weather
//
//  Created by Alex on 10.02.2024.
//

import Foundation
import Combine

class CitiesListViewModel: ObservableObject {
    
    var isDataDownloaded: Bool
    
    @Published var isLoading: Bool
    @Published var cities: [City]
    
    @Published var searchText: String
    @Published var autocompletionCities: [City]
    
    var showErrorPublisher = PassthroughSubject<String, Error>()
    
    init() {
        isDataDownloaded = false
        isLoading = false
        cities = []
        searchText = ""
        autocompletionCities = []
    }
}

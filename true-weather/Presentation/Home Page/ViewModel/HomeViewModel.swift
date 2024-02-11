//
//  HomeViewModel.swift
//  true-weather
//
//  Created by Alex on 11.02.2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    var showCitiesListPublisher = PassthroughSubject<Void, Never>()
    
    
    func showCitiesList() {
        showCitiesListPublisher.send()
    }
}

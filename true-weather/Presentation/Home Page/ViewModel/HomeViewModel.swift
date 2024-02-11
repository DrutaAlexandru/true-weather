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
    var continueWithCurrentLocationPublisher = PassthroughSubject<Void, Never>()
    var showLocationErrorPublisher = PassthroughSubject<Void, Never>()
    
    private var cancellable: AnyCancellable? = nil
    
    func showCitiesList() {
        showCitiesListPublisher.send()
    }
    
    func requestLocationPermission() {
        switch LocationManager.shared.checkPermissionStatus() {
        case .notRequested:
            Task {
                LocationManager.shared.requestLocationPermission()
                cancellable = Timer.publish(every: 1, on: .main, in: .default)
                    .autoconnect()
                    .sink { _ in
                        switch LocationManager.shared.checkPermissionStatus() {
                        case .notRequested: break
                        case .allowed:
                            DispatchQueue.main.async { [weak self] in
                                self?.continueWithCurrentLocationPublisher.send()
                                self?.cancellable?.cancel()
                            }
                        case .denied:
                            DispatchQueue.main.async { [weak self] in
                                self?.showLocationErrorPublisher.send()
                                self?.cancellable?.cancel()
                            }
                        }
                    }
            }
        case .allowed:
            continueWithCurrentLocationPublisher.send()
        case .denied:
            showLocationErrorPublisher.send()
        }
    }
}

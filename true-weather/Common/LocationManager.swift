//
//  LocationManager.swift
//  true-weather
//
//  Created by Alex on 11.02.2024.
//

import Foundation
import CoreLocation
import Combine

enum LocationStatus {
    case notRequested
    case allowed
    case denied
}

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    public static let shared = LocationManager()
    
    private var locationManager = CLLocationManager()
    private var locationCompletion: ((Result<CLLocation, Error>) -> Void)?
    
    private override init() { 
        super.init()
        locationManager.delegate = self
    }
    
    // MARK: - Public methods
    func checkPermissionStatus() -> LocationStatus {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            return .notRequested
        case .restricted:
            return .denied
        case .denied:
            return .denied
        case .authorizedAlways:
            return .allowed
        case .authorizedWhenInUse:
            return .allowed
        @unknown default:
            return .notRequested
        }
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getCurrentLocation() async throws -> CLLocation {
        let status = checkPermissionStatus()
        guard status == .allowed else {
            throw LocationUnavaliable()
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            self.locationCompletion = continuation.resume
            locationManager.requestLocation()
        }
    }
    
    // MARK: - CLLocationManagerDelegate methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationCompletion?(.success(location))
            locationCompletion = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationCompletion?(.failure(error))
        locationCompletion = nil
    }
}

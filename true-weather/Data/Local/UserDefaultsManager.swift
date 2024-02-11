//
//  UserDefaultsManager.swift
//  true-weather
//
//  Created by Alex on 11.02.2024.
//

import Foundation

struct UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    private let userDefaults = UserDefaults.standard
    
    private let citiesList = "cities_list"
    private let selectedCity = "selected_city"
    
    func getCitiesList() -> [City] {
        guard let savedCitiesList = userDefaults.string(forKey: citiesList),
              let savedCitiesListData = savedCitiesList.data(using: .utf8),
              let citiesList = try? SaveableCityResponseMapper(data: savedCitiesListData).map() else {
            return []
        }
        return citiesList
    }
    
    func setCitiesList(_ cities: [City]) {
        let saveableCities = cities.map({ SaveableCity(city: $0) })
        guard let data = try? JSONEncoder().encode(saveableCities) else { return }
        userDefaults.set(String(data: data, encoding: String.Encoding.utf8), forKey: citiesList)
        userDefaults.synchronize()
    }
    
    func getSelectedCity() -> City? {
        let cityId = userDefaults.integer(forKey: selectedCity)
        if cityId != 0 {
            let cities = getCitiesList()
            return cities.first(where: { $0.id == cityId })
        }
        return nil
    }
    
    func setSelectedCity(_ city: City?) {
        if let city {
            userDefaults.setValue(city.id, forKey: selectedCity)
        } else {
            userDefaults.removeObject(forKey: selectedCity)
        }
        userDefaults.synchronize()
    }
    
}

// MARK: - Response Mapper to transform the JSON Response Object to [City] object

private struct SaveableCityResponseMapper {
    let data: Data
    var jsonDecoder: JSONDecoder = JSONDecoder()
    
    func map() throws -> [City] {
        do {
            let apiResponse = try jsonDecoder.decode([SaveableCity].self, from: data)
            return apiResponse.map({
                City(id: $0.id,
                     name: $0.name,
                     country: $0.country,
                     latitude: $0.latitude,
                     longitude: $0.longitude)
            })
        } catch {
            throw JSONParsingError()
        }
    }
}

// MARK: - Response Object Codable objects
private struct SaveableCity: Codable {
    let id: Int
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double
    
    init(city: City) {
        id = city.id
        name = city.name
        country = city.country
        latitude = city.latitude
        longitude = city.longitude
    }
}

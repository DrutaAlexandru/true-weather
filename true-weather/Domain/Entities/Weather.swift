//
//  Weather.swift
//  true-weather
//
//  Created by Alex on 09.02.2024.
//

import Foundation

struct Weather {
    let latitude: Double
    let longitude: Double
    let current: CurrentWeather
    let forecast: [DailyWeather]
    
    var coordinates: Coordinates {
        Coordinates(latitude: latitude, longitude: longitude)
    }
}

struct CurrentWeather {
    private let temperatureValue: Double
    private let temperatureUnit: String
    
    private let apparentTemperatureValue: Double
    private let apparentTemperatureUnit: String
    
    private let relativeHumidityValue: Double
    private let relativeHumidityUnit: String
    
    private let precipitationValue: Int
    private let precipitationUnit: String
    
    private let rainValue: Int
    private let rainUnit: String
    
    private let showersValue: Int
    private let showersUnit: String
    
    private let snowfallValue: Int
    private let snowfallUnit: String
    
    private let weatherCode: Int
    
    private let cloudCoverValue: Int
    private let cloudCoverUnit: String
    
    private let windSpeedValue: Double
    private let windSpeedUnit: String
    
    private let windDirectionValue: Double
    private let windDirectionUnit: String
    
    let isDay: Bool

    init(temperatureValue: Double, 
         temperatureUnit: String,
         apparentTemperatureValue: Double,
         apparentTemperatureUnit: String,
         relativeHumidityValue: Double,
         relativeHumidityUnit: String,
         precipitationValue: Int,
         precipitationUnit: String,
         rainValue: Int,
         rainUnit: String,
         showersValue: Int,
         showersUnit: String,
         snowfallValue: Int,
         snowfallUnit: String,
         weatherCode: Int,
         cloudCoverValue: Int,
         cloudCoverUnit: String,
         windSpeedValue: Double,
         windSpeedUnit: String,
         windDirectionValue: Double,
         windDirectionUnit: String, isDay: Bool) {
        self.temperatureValue = temperatureValue
        self.temperatureUnit = temperatureUnit
        self.apparentTemperatureValue = apparentTemperatureValue
        self.apparentTemperatureUnit = apparentTemperatureUnit
        self.relativeHumidityValue = relativeHumidityValue
        self.relativeHumidityUnit = relativeHumidityUnit
        self.precipitationValue = precipitationValue
        self.precipitationUnit = precipitationUnit
        self.rainValue = rainValue
        self.rainUnit = rainUnit
        self.showersValue = showersValue
        self.showersUnit = showersUnit
        self.snowfallValue = snowfallValue
        self.snowfallUnit = snowfallUnit
        self.weatherCode = weatherCode
        self.cloudCoverValue = cloudCoverValue
        self.cloudCoverUnit = cloudCoverUnit
        self.windSpeedValue = windSpeedValue
        self.windSpeedUnit = windSpeedUnit
        self.windDirectionValue = windDirectionValue
        self.windDirectionUnit = windDirectionUnit
        self.isDay = isDay
    }
    
    var temperature: String {
        "\(String(format: "%0.1f", temperatureValue))\(temperatureUnit)"
    }
    
    var apparentTemperature: String {
        "\(String(format: "%0.1f", apparentTemperatureValue))\(apparentTemperatureUnit)"
    }
    
    var relativeHumidity: String {
        "\(Int(relativeHumidityValue)) \(relativeHumidityUnit)"
    }
    
    var precipitation: String {
        "\(precipitationValue) \(precipitationUnit)"
    }
    
    var rain: String {
        "\(rainValue) \(rainUnit)"
    }
    
    var showers: String {
        "\(showersValue) \(showersUnit)"
    }
    
    var snowfall: String {
        "\(snowfallValue) \(snowfallUnit)"
    }
    
    var weatherIcon: String {
        WeatherData(code: weatherCode).icon
    }
    
    var cloudCover: String {
        "\(cloudCoverValue) \(cloudCoverUnit)"
    }
    
    var windSpeed: String {
        "\(String(format: "%0.1f", windSpeedValue)) \(windSpeedUnit)"
    }
    
    var windDirectionDegrees: String {
        "\(windDirectionValue)\(windDirectionUnit)"
    }
    
    var windDirectionDescription: String {
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        let index = Int((windDirectionValue + 22.5) / 45) % 8
        return directions[index]
    }
}

struct DailyWeather {
    private let time: String
    private let temperatureMinValue: Double
    private let temperatureMaxValue: Double
    private let temperatureMinUnit: String
    private let temperatureMaxUnit: String
    private let weatherCode: Int
    
    init(time: String, 
         temperatureMinValue: Double,
         temperatureMaxValue: Double,
         temperatureMinUnit: String,
         temperatureMaxUnit: String, weatherCode: Int) {
        self.time = time
        self.temperatureMinValue = temperatureMinValue
        self.temperatureMaxValue = temperatureMaxValue
        self.temperatureMinUnit = temperatureMinUnit
        self.temperatureMaxUnit = temperatureMaxUnit
        self.weatherCode = weatherCode
    }
    
    var dayName: String {
        time.formatDateToDayName()
    }
    
    var minTemperature: String {
        "\(String(format: "%0.1f", temperatureMinValue))\(temperatureMinUnit)"
    }
    
    var maxTemperature: String {
        "\(String(format: "%0.1f", temperatureMaxValue))\(temperatureMaxUnit)"
    }
    
    var weatherIcon: String {
        WeatherData(code: weatherCode).icon
    }
}

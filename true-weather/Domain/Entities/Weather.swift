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

#if DEBUG
extension Weather {
    static let mock = Weather(
        latitude: 47.00556,
        longitude: 28.8575,
        current: CurrentWeather(
            temperatureValue: 7.7,
            temperatureUnit: "°C",
            apparentTemperatureValue: 6,
            apparentTemperatureUnit: "°C",
            relativeHumidityValue: 80,
            relativeHumidityUnit: "%",
            precipitationValue: 0,
            precipitationUnit: "mm",
            rainValue: 0,
            rainUnit: "mm",
            showersValue: 0,
            showersUnit: "mm",
            snowfallValue: 0,
            snowfallUnit: "cm",
            weatherCode: 0,
            cloudCoverValue: 93,
            cloudCoverUnit: "%",
            windSpeedValue: 2.4,
            windSpeedUnit: "km/h",
            windDirectionValue: 117,
            windDirectionUnit: "°",
            isDay: true
        ),
        forecast: [
            DailyWeather(time: "2024-02-11",
                         temperatureMinValue: 6.9,
                         temperatureMaxValue: 13.8,
                         temperatureMinUnit: "°C",
                         temperatureMaxUnit: "°C",
                         weatherCode: 61),
            DailyWeather(time: "2024-02-12",
                         temperatureMinValue: 6.4,
                         temperatureMaxValue: 16.9,
                         temperatureMinUnit: "°C",
                         temperatureMaxUnit: "°C",
                         weatherCode: 3),
            DailyWeather(time: "2024-02-13",
                         temperatureMinValue: 8,
                         temperatureMaxValue: 14,
                         temperatureMinUnit: "°C",
                         temperatureMaxUnit: "°C",
                         weatherCode: 3),
            DailyWeather(time: "2024-02-14",
                         temperatureMinValue: 7.5,
                         temperatureMaxValue: 13.2,
                         temperatureMinUnit: "°C",
                         temperatureMaxUnit: "°C",
                         weatherCode: 95),
            DailyWeather(time: "2024-02-15",
                         temperatureMinValue: 3,
                         temperatureMaxValue: 8.7,
                         temperatureMinUnit: "°C",
                         temperatureMaxUnit: "°C",
                         weatherCode: 3),
            DailyWeather(time: "2024-02-16",
                         temperatureMinValue: 0.5,
                         temperatureMaxValue: 7.6,
                         temperatureMinUnit: "°C",
                         temperatureMaxUnit: "°C",
                         weatherCode: 3),
            DailyWeather(time: "2024-02-17",
                         temperatureMinValue: 1.2,
                         temperatureMaxValue: 7.3,
                         temperatureMinUnit: "°C",
                         temperatureMaxUnit: "°C",
                         weatherCode: 3),
        ]
    )
}
#endif

struct CurrentWeather {
    private let temperatureValue: Double
    private let temperatureUnit: String
    
    private let apparentTemperatureValue: Double
    private let apparentTemperatureUnit: String
    
    private let relativeHumidityValue: Double
    private let relativeHumidityUnit: String
    
    private let precipitationValue: Double
    private let precipitationUnit: String
    
    private let rainValue: Double
    private let rainUnit: String
    
    private let showersValue: Double
    private let showersUnit: String
    
    private let snowfallValue: Double
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
         precipitationValue: Double,
         precipitationUnit: String,
         rainValue: Double,
         rainUnit: String,
         showersValue: Double,
         showersUnit: String,
         snowfallValue: Double,
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
        "\(String(format: "%0.1f", precipitationValue)) \(precipitationUnit)"
    }
    
    var rain: String {
        "\(String(format: "%0.1f", rainValue)) \(rainUnit)"
    }
    
    var showers: String {
        "\(String(format: "%0.1f", showersValue)) \(showersUnit)"
    }
    
    var snowfall: String {
        "\(String(format: "%0.1f", snowfallValue)) \(snowfallUnit)"
    }
    
    var weatherIcon: String {
        WeatherData(code: weatherCode).icon(isDay: isDay)
    }
    
    var weatherDescription: String {
        WeatherData(code: weatherCode).description
    }
    
    var weatherTrueTitle: String {
        WeatherData(code: weatherCode).title
    }
    
    var weatherTrueSubtitle: String {
        WeatherData(code: weatherCode).subtitle
    }
    
    var weatherTrueAccentColor: String {
        WeatherData(code: weatherCode).color
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

struct DailyWeather: Identifiable {
    let id: UUID
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
         temperatureMaxUnit: String, 
         weatherCode: Int) {
        self.id = UUID()
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
        WeatherData(code: weatherCode).icon()
    }
}

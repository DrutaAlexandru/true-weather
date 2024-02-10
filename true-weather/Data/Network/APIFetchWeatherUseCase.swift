//
//  APIFetchWeatherUseCase.swift
//  true-weather
//
//  Created by Alex on 10.02.2024.
//

import Foundation

final class APIFetchWeatherUseCase: FetchWeatherUseCase {
    
    public static let shared = APIFetchWeatherUseCase()
    
    private init() { }
    
    func getWeather(for coordinates: Coordinates) async throws -> Weather {
        guard var url = URL(string: APIEndpoints.weather.rawValue) else { throw NetworkError.invalidRequest }
        url.append(queryItems: [
            URLQueryItem(name: "latitude", value: String(coordinates.latitude)),
            URLQueryItem(name: "longitude", value: String(coordinates.longitude)),
            URLQueryItem(name: "current", value: "temperature_2m,relative_humidity_2m,apparent_temperature,is_day,precipitation,rain,showers,snowfall,weather_code,cloud_cover,wind_speed_10m,wind_direction_10m"),
            URLQueryItem(name: "daily", value: "weather_code,temperature_2m_max,temperature_2m_min")
        ])
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            try APIResponseParser().parse(response, with: data)
            
            return try APIFetchWeatherResponseMapper(data: data).map()
        } catch {
            if let urlError = error as? URLError, urlError.code == URLError.timedOut {
                throw NetworkError.timeout
            } else {
                throw error
            }
        }
    }
}

private struct APIFetchWeatherResponseMapper {
    let data: Data
    var jsonDecoder: JSONDecoder = JSONDecoder()

    func map() throws -> Weather {
        do {
            let apiResponse = try jsonDecoder.decode(APIWeather.self, from: data)
        
            let currentWeather = CurrentWeather(temperatureValue: apiResponse.currentData.temperature,
                                                temperatureUnit: apiResponse.currentUnits.temperature,
                                                apparentTemperatureValue: apiResponse.currentData.apparentTemperature,
                                                apparentTemperatureUnit: apiResponse.currentUnits.apparentTemperature,
                                                relativeHumidityValue: apiResponse.currentData.relativeHumidity,
                                                relativeHumidityUnit: apiResponse.currentUnits.relativeHumidity,
                                                precipitationValue: apiResponse.currentData.precipitation,
                                                precipitationUnit: apiResponse.currentUnits.precipitation,
                                                rainValue: apiResponse.currentData.rain,
                                                rainUnit: apiResponse.currentUnits.rain,
                                                showersValue: apiResponse.currentData.showers,
                                                showersUnit: apiResponse.currentUnits.showers,
                                                snowfallValue: apiResponse.currentData.snowfall,
                                                snowfallUnit: apiResponse.currentUnits.snowfall,
                                                weatherCode: apiResponse.currentData.weatherCode,
                                                cloudCoverValue: apiResponse.currentData.cloudCover,
                                                cloudCoverUnit: apiResponse.currentUnits.cloudCover,
                                                windSpeedValue: apiResponse.currentData.windSpeed,
                                                windSpeedUnit: apiResponse.currentUnits.windSpeed,
                                                windDirectionValue: apiResponse.currentData.windDirection,
                                                windDirectionUnit: apiResponse.currentUnits.windDirection,
                                                isDay: apiResponse.currentData.isDay == 1)
            var dailyWeather: [DailyWeather] = []
            if !apiResponse.dailyData.time.isEmpty,
               apiResponse.dailyData.weatherCode.count == apiResponse.dailyData.time.count,
               apiResponse.dailyData.temperatureMin.count == apiResponse.dailyData.time.count,
               apiResponse.dailyData.temperatureMax.count == apiResponse.dailyData.time.count {
                for index in 0..<apiResponse.dailyData.time.count {
                    dailyWeather.append(DailyWeather(time: apiResponse.dailyData.time[index],
                                                     temperatureMinValue: apiResponse.dailyData.temperatureMin[index],
                                                     temperatureMaxValue: apiResponse.dailyData.temperatureMax[index],
                                                     temperatureMinUnit: apiResponse.dailyUnits.temperatureMin,
                                                     temperatureMaxUnit: apiResponse.dailyUnits.temperatureMax,
                                                     weatherCode: apiResponse.dailyData.weatherCode[index]))
                }
            }
            
            return Weather(latitude: apiResponse.latitude,
                           longitude: apiResponse.longitude,
                           current: currentWeather,
                           forecast: dailyWeather)
        } catch {
            throw JSONParsingError()
        }
    }
}

private struct APIWeather: Decodable {
    let latitude: Double
    let longitude: Double
    let currentUnits: APICurrentUnits
    let currentData: APICurrentData
    let dailyUnits: APIDailyUnits
    let dailyData: APIDailyData
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case currentUnits = "current_units"
        case currentData = "current"
        case dailyUnits = "daily_units"
        case dailyData = "daily"
    }
}

private struct APICurrentUnits: Decodable {
    let temperature: String
    let relativeHumidity: String
    let apparentTemperature: String
    let precipitation: String
    let rain: String
    let showers: String
    let snowfall: String
    let cloudCover: String
    let windSpeed: String
    let windDirection: String
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temperature_2m"
        case relativeHumidity = "relative_humidity_2m"
        case apparentTemperature = "apparent_temperature"
        case precipitation
        case rain
        case showers
        case snowfall
        case cloudCover = "cloud_cover"
        case windSpeed = "wind_speed_10m"
        case windDirection = "wind_direction_10m"
    }
}

private struct APICurrentData: Decodable {
    let temperature: Double
    let relativeHumidity: Double
    let apparentTemperature: Double
    let isDay: Int
    let precipitation: Int
    let rain: Int
    let showers: Int
    let snowfall: Int
    let weatherCode: Int
    let cloudCover: Int
    let windSpeed: Double
    let windDirection: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temperature_2m"
        case relativeHumidity = "relative_humidity_2m"
        case apparentTemperature = "apparent_temperature"
        case isDay = "is_day"
        case precipitation
        case rain
        case showers
        case snowfall
        case weatherCode = "weather_code"
        case cloudCover = "cloud_cover"
        case windSpeed = "wind_speed_10m"
        case windDirection = "wind_direction_10m"
    }
}

private struct APIDailyUnits: Decodable {
    let temperatureMax: String
    let temperatureMin: String
    
    enum CodingKeys: String, CodingKey {
        case temperatureMax = "temperature_2m_max"
        case temperatureMin = "temperature_2m_min"
    }
}

private struct APIDailyData: Decodable {
    let time: [String]
    let weatherCode: [Int]
    let temperatureMax: [Double]
    let temperatureMin: [Double]
    
    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
        case temperatureMax = "temperature_2m_max"
        case temperatureMin = "temperature_2m_min"
    }
}

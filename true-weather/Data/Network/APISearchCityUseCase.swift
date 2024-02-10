//
//  APISearchCityUseCase.swift
//  true-weather
//
//  Created by Alex on 10.02.2024.
//

import Foundation

final class APISearchCityUseCase: SearchCityUseCase {
    
    public static let shared = APISearchCityUseCase()
    
    func fetchResults(with query: String) async throws -> [City] {
        guard var url = URL(string: APIEndpoints.autocomplete.rawValue) else { throw NetworkError.invalidRequest }
        url.append(queryItems: [
            URLQueryItem(name: "name", value: query),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "language", value: "en"),
            URLQueryItem(name: "format", value: "json")
        ])
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            try APIResponseParser().parse(response, with: data)
            
            return try APISearchCityResponseMapper(data: data).map()
        } catch {
            if let urlError = error as? URLError, urlError.code == URLError.timedOut {
                throw NetworkError.timeout
            } else {
                throw error
            }
        }
    }
}

private struct APISearchCityResponseMapper {
    let data: Data
    var jsonDecoder: JSONDecoder = JSONDecoder()
    
    func map() throws -> [City] {
        do {
            let apiResponse = try jsonDecoder.decode(APISearchCityResponse.self, from: data)
            return apiResponse.results.map({
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

private struct APISearchCityResponse: Decodable {
    let results: [APICity]
}

private struct APICity: Decodable {
    let id: Int
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double
}

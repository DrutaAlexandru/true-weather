//
//  APIResponseParser.swift
//  true-weather
//
//  Created by Alex on 10.02.2024.
//

import Foundation

struct APIResponseParser {
    func parse(_ response: URLResponse, with data: Data) throws {
        if let httpResponse = response as? HTTPURLResponse {
            let statusCode = httpResponse.statusCode
            
            if (200..<300).contains(statusCode) {
                // Request succeeded
            } else if statusCode == 400 {
                do {
                    let apiResponse = try JSONDecoder().decode(APIError.self, from: data)
                    throw NetworkError.error(apiResponse.reason)
                } catch {
                    throw JSONParsingError()
                }
            } else {
                do {
                    let apiResponse = try JSONDecoder().decode(APIError.self, from: data)
                    throw NetworkError.error(apiResponse.reason)
                } catch {
                    throw NetworkError.invalidResponse
                }
                    
            }
        } else {
            throw NetworkError.invalidResponse
        }
    }
}

private struct APIError: Codable {
    let error: Bool
    let reason: String
}

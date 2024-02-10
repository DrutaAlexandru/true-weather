//
//  APIResponseParser.swift
//  true-weather
//
//  Created by Alex on 10.02.2024.
//

import Foundation

/// API Response parser checks the response recevied from the request,
/// if the staus code is `400` then something went wrong and the error is thrown.
///
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

// MARK: - Error JSON Response object

private struct APIError: Codable {
    let error: Bool
    let reason: String
}

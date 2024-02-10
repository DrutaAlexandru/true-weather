//
//  NetworkError.swift
//  true-weather
//
//  Created by Alex on 10.02.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case timeout
    case error(String)
}

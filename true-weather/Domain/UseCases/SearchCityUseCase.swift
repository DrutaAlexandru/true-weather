//
//  SearchCityUseCase.swift
//  true-weather
//
//  Created by Alex on 10.02.2024.
//

import Foundation

protocol SearchCityUseCase {
    func fetchResults(with query: String) async throws -> [City]
}

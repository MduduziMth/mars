//
//  Forecast.swift
//  Weather on Mars
//
//  Created by Mduduzi Mthethwa on 2023/06/13.
//

import Foundation
struct Forecast: Codable {
    let date: String
    let temp: Double
    let humidity: Double
    let windSpeed: Double
    let safe: Bool
}

struct WeatherData: Codable {
    let forecasts: [Forecast]
    let lastUpdated: String
    let weatherStation: String
}

enum WeatherServiceError: Error {
    case invalidResponse
    case networkError(Error)
    case decodingError(String)
}

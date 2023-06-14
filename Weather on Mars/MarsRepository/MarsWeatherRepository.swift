//
//  MarsWeatherRepository.swift
//  Weather on Mars
//
//  Created by Mduduzi Mthethwa on 2023/06/13.
//

import Foundation
protocol MarsWeatherRepositoryProtocol {
    func getWeatherData(completion: @escaping (Result<WeatherData, WeatherServiceError>) -> Void)
}

class MarsWeatherRepository: MarsWeatherRepositoryProtocol {
    let dependencyContainer = MarsDependencyContainer()
    lazy var weatherService: WeatherServiceProtocol = dependencyContainer.resolveMarsWeatherService()
        
    func getWeatherData(completion: @escaping (Result<WeatherData, WeatherServiceError>) -> Void) {
        weatherService.fetchWeatherData(completion: completion)
    }
}

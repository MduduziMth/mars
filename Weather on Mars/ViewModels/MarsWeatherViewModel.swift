//
//  MarsWeatherViewModel.swift
//  Weather on Mars
//
//  Created by Mduduzi Mthethwa on 2023/06/13.
//

import Foundation

protocol WeatherViewModelDelegate: AnyObject {
    func weatherDataFetched()
    func weatherDataFetchFailed(with error: Error)
    func weatherDataFetchStarted()
}

class MarsWeatherViewModel {
    let dependencyContainer = MarsDependencyContainer()
    lazy var weatherRepository: MarsWeatherRepositoryProtocol = dependencyContainer.resolveMarsWeatherRepository()
    private var weatherData: WeatherData?
    weak var delegate: WeatherViewModelDelegate?
    
    
        
    func fetchWeatherData() {
        delegate?.weatherDataFetchStarted()
        DispatchQueue.global().async { [weak self] in
            self?.weatherRepository.getWeatherData { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let weatherData):
                        self?.weatherData = weatherData
                        self?.delegate?.weatherDataFetched()
                    case .failure(let error):
                        self?.delegate?.weatherDataFetchFailed(with: error)
                    }
                }
            }
        }

    }
        
    var numberOfForecasts: Int {
        return weatherData?.forecasts.count ?? 0
    }
    
    func forecast(at index: Int) -> Forecast? {
        return weatherData?.forecasts[index]
    }
    
    var lastUpdated: String? {
        return weatherData?.lastUpdated
    }
    
    var weatherStation: String? {
        return weatherData?.weatherStation
    }
}

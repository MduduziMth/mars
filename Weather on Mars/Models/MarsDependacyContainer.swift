//
//  MarsDependacyContainer.swift
//  Weather on Mars
//
//  Created by Mduduzi Mthethwa on 2023/06/14.
//

import Foundation
import Swinject

public class MarsDependencyContainer {
    
    private let container: Container
    
    init() {
        container = Container()
        
        // Register dependencies
        container.register(WeatherServiceProtocol.self) { _ in MarsWeatherService() }
        container.register(MarsWeatherRepositoryProtocol.self) { _ in MarsWeatherRepository() }
    }
    
    
    func resolveMarsWeatherService() -> WeatherServiceProtocol {
            return container.resolve(WeatherServiceProtocol.self)!
    }
    
    func resolveMarsWeatherRepository() -> MarsWeatherRepositoryProtocol {
        return container.resolve(MarsWeatherRepositoryProtocol.self)!
    }
}

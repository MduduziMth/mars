//
//  MarsWeatherService.swift
//  Weather on Mars
//
//  Created by Mduduzi Mthethwa on 2023/06/13.
//

import Foundation


protocol WeatherServiceProtocol {
    func fetchWeatherData(completion: @escaping (Result<WeatherData, WeatherServiceError>) -> Void)
}

class MarsWeatherService: WeatherServiceProtocol {
    private let url = URL(string: "https://run.mocky.io/v3/1fd068d7-cbb2-4ceb-b697-da7fcc1c520b")!

    private let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return decoder
    }()
    
    
    func fetchWeatherData(completion: @escaping (Result<WeatherData, WeatherServiceError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        completion(.failure(.networkError(error)))
                        return
                    }
                    
                    guard let data = data else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                  //  print(String(data: data, encoding: .utf8))
            
                    do {
                        let weatherData = try self.decoder.decode(WeatherData.self, from: data)
                        completion(.success(weatherData))
                    } catch let decodingError {
                        completion(.failure(.decodingError(decodingError.localizedDescription)))
                    }
                }
                
        task.resume()
    }
        
}

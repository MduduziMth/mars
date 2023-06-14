//
//  ViewController.swift
//  Weather on Mars
//
//  Created by Mduduzi Mthethwa on 2023/06/13.
//

import UIKit

class ViewController: UIViewController, WeatherViewModelDelegate {
        private let weatherViewModel: MarsWeatherViewModel
    
        @IBOutlet private var lastUpdatedLabel: UILabel!
        @IBOutlet private var weatherStationLabel: UILabel!
        @IBOutlet private var forecastsTableView: UITableView!
        @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    init(weatherViewModel: MarsWeatherViewModel) {
            self.weatherViewModel = weatherViewModel
            super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
        self.weatherViewModel = MarsWeatherViewModel()
        super.init(coder: coder)
    }
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            weatherViewModel.delegate = self
            weatherViewModel.fetchWeatherData()
            
            forecastsTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "ForecastCell")
            forecastsTableView.dataSource = self
            lastUpdatedLabel.text = ""
            weatherStationLabel.text = ""
        }
        
    
    func weatherDataFetched() {
        lastUpdatedLabel.text = "Last Updated " + weatherViewModel.lastUpdated!
        weatherStationLabel.text = "Station: " + weatherViewModel.weatherStation!
        forecastsTableView.reloadData()
        
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
    }
    
    func weatherDataFetchFailed(with error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
        
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
    }
    
    func weatherDataFetchStarted() {
        loadingIndicator.startAnimating()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherViewModel.numberOfForecasts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath)
        
        if let forecastCell = cell as? CustomTableViewCell,
                let forecast = weatherViewModel.forecast(at: indexPath.row) {
                forecastCell.configure(with: forecast)
        }
        
        return cell
    }
}


//
//  TableViewCell.swift
//  Weather on Mars
//
//  Created by Mduduzi Mthethwa on 2023/06/13.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var safeLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with forecast: Forecast) {
        dateLabel?.text = "Date:\(forecast.date)"
        tempLabel?.text = "Temperature: \(forecast.temp) degrees"
        humidityLabel?.text = "Humidity: \(forecast.humidity)"
        windSpeedLabel?.text = "WindSpeed: \(forecast.windSpeed)"
        safeLabel?.text = "Safe: \(forecast.safe)"
    }
    
}

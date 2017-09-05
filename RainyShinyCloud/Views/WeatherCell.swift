//
//  WeatherCell.swift
//  RainyShinyCloud
//
//  Created by Ahmad Ayman on 8/28/17.
//  Copyright © 2017 Ahmad Ayman. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherStatusImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(forecast: Forecast){
        weatherStatusImage.image = UIImage(named: forecast.weatherType)
        dateLabel.text = forecast.date
        weatherStatusLabel.text = forecast.weatherType
        maxTempLabel.text = forecast.highTemp
        lowTempLabel.text = forecast.lowTemp
    }

}

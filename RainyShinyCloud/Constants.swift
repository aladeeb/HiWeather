//
//  Constants.swift
//  RainyShinyCloud
//
//  Created by Ahmad Ayman on 8/27/17.
//  Copyright © 2017 Ahmad Ayman. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let FORECAST_BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let LATITUDE = "lat=\(Location.sharedInstance.latitude!)"
let LONGITUDE = "&lon=\(Location.sharedInstance.longitude!)"
let CNT = "&cnt=7"
let APP_ID = "&appid="
let API_KEY = "f0023d3db1681a6adaa3597a65c8eba9"

typealias DownloadCompleted = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(LONGITUDE)\(APP_ID)\(API_KEY)"
let FORECAST_URL = "\(FORECAST_BASE_URL)\(LATITUDE)\(LONGITUDE)\(CNT)\(APP_ID)\(API_KEY)"

func convertToCelsius(kelvin: Double) -> Double {
    let kelvinToCelsiusPreDivision = (kelvin - 273.15)
    let kelvinToCelsius = Double(round(10 * kelvinToCelsiusPreDivision/10))
    return kelvinToCelsius
}

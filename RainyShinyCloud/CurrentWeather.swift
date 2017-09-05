//
//  CurrentWeather.swift
//  RainyShinyCloud
//
//  Created by Ahmad Ayman on 8/27/17.
//  Copyright © 2017 Ahmad Ayman. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String{
        return _cityName == nil ? "" : _cityName
    }

    var weatherType: String{
        return _weatherType == nil ? "" : _weatherType
    }
    
    var currentTemp: Double{
        return _currentTemp == nil ? 0.0 : _currentTemp
    }
    
    var date: String{
        if _date == nil{
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    func downloadWeatherData(completed: @escaping DownloadCompleted) {
        let currentWeatherUrl = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherUrl).responseJSON { response in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemp = main["temp"] as? Double {
                        self._currentTemp = convertToCelsius(kelvin: currentTemp)
                    }
                }
            }
            completed()
        }
    }
    
}

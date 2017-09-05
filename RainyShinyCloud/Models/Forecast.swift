//
//  Forecast.swift
//  RainyShinyCloud
//
//  Created by Ahmad Ayman on 8/27/17.
//  Copyright © 2017 Ahmad Ayman. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    var _highTemp: String!
    var _lowTemp: String!
    var _weatherType: String!
    var _date: String!
    
    init(dict: Dictionary<String, AnyObject>) {
        if let temp = dict["temp"] as? Dictionary<String, AnyObject> {
            if let high = temp["max"] as? Double {
                self._highTemp = "\(convertToCelsius(kelvin: high))"
            }
            if let low = temp["min"] as? Double {
                self._lowTemp = "\(convertToCelsius(kelvin: low))"
            }
        }
        
        if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
            if let weatherType = weather[0]["main"] as? String {
                self._weatherType = weatherType
            }
        }
        
        if let dateDouble = dict["dt"] as? Double {
            let unixDate = Date(timeIntervalSince1970: dateDouble)
            self._date = unixDate.weekDay()
        }
    }

    var highTemp: String {
        return _highTemp == nil ? "" : _highTemp
    }
    
    var lowTemp: String {
        return _lowTemp == nil ? "" : _lowTemp
    }
    
    var weatherType: String {
        return _weatherType == nil ? "" : _weatherType
    }
    
    var date: String {
        return _date == nil ? "" : _date
    }
    
}

extension Date {
    func weekDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}


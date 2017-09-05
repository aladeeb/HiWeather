//
//  ViewController.swift
//  RainyShinyCloud
//
//  Created by Ahmad Ayman on 8/24/17.
//  Copyright © 2017 Ahmad Ayman. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var todaysDate: UILabel!
    @IBOutlet weak var todaysTemp: UILabel!
    @IBOutlet weak var currentLocation: UILabel!
    @IBOutlet weak var weatherStatus: UILabel!
    @IBOutlet weak var weatherStatusImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocationFromGPS = CLLocation()
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
        print(CURRENT_WEATHER_URL)
        print(FORECAST_URL)
    }
    
    func locationAuthStatus () {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocationFromGPS = locationManager.location!
            Location.sharedInstance.longitude = currentLocationFromGPS.coordinate.longitude
            Location.sharedInstance.latitude = currentLocationFromGPS.coordinate.latitude
            print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
            currentWeather.downloadWeatherData {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadCompleted) {
        let forecastUrl = URL(string: FORECAST_URL)!
        Alamofire.request(forecastUrl).responseJSON { response in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String,AnyObject>] {
                    for obj in list {
                        let forecast = Forecast(dict: obj)
                        self.forecasts.append(forecast)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func updateMainUI() {
        todaysDate.text = currentWeather.date
        todaysTemp.text = "\(currentWeather.currentTemp)"
        weatherStatus.text = currentWeather.weatherType
        currentLocation.text = currentWeather.cityName
        weatherStatusImage.image = UIImage(named: currentWeather.weatherType)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let item =  forecasts[indexPath.row]
            cell.configureCell(forecast: item)
            return cell
        }else{
            return UITableViewCell()
        }
    }
}


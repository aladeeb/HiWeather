//
//  Location.swift
//  RainyShinyCloud
//
//  Created by Ahmad Ayman on 8/28/17.
//  Copyright © 2017 Ahmad Ayman. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {
        
    }
    
    var latitude: Double!
    var longitude: Double!
}

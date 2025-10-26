//
//  MapLocation.swift
//  Beacon
//

// Model for users map placement

import SwiftData

@Model
class MapLocation {
    var longitude: Double
    var latitude: Double
    
    init(longitude: Double, latitude: Double){
        self.longitude = longitude
        self.latitude = latitude
    }
}

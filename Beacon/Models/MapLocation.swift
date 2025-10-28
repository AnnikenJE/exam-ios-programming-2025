//
//  MapLocation.swift
//  Beacon
//

// Model for users recent map placement 

import SwiftData
import MapKit

@Model
class MapLocation {
    var position: String
    var longitude: CLLocationDegrees
    var latitude: CLLocationDegrees
    
    init(position: String,longitude: CLLocationDegrees, latitude: CLLocationDegrees){
        self.position = position
        self.longitude = longitude
        self.latitude = latitude
    }
}

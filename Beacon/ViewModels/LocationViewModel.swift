//
//  LocationViewModel.swift
//  Beacon
//
// Kandidatnr 97

// Viewmodel for tracking user location

import SwiftUI
import Foundation
import Combine
import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // Published
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var locationString = "Ingen lokasjon..."
    
    // Variables
    private let locationManager = CLLocationManager()
    
    // Initializer
    override init(){
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // Functions
    func requestLocation(){
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Functions that automaticly is called by the app
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        if let location = locations.last {
            locationString = "Current user location: \nLatitude \(location.coordinate.latitude), \nLongitude \(location.coordinate.longitude)"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
}

//
//  MapView.swift
//  Beacon
//

import SwiftUI
import MapKit

struct ExploreMapView: View {
    @Binding var places: [Places]
    
    // Default location on startup, Oslo Central Station
    @State private var location: MapCameraPosition = .region(
        MKCoordinateRegion(center:
                            CLLocationCoordinate2D(latitude: 59.9111, longitude: 10.7503),
                           span:
                            MKCoordinateSpan.init(latitudeDelta: 0.003, longitudeDelta: 0.003)))
    
    var body: some View{
        Map(position: $location){
            ForEach(places, id: \.self) { place in
                ForEach(place.features, id: \.self) { place in
                    Marker(place.properties.name, coordinate: CLLocationCoordinate2D.init(latitude: place.properties.lat, longitude: place.properties.lon))
                }
            }
        }
        .ignoresSafeArea()
    }
}


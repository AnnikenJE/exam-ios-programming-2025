//
//  MapView.swift
//  Beacon
//

import SwiftUI
import MapKit

struct ExploreMapView: View {
    
    @Binding var places: [Places]
    @Binding var location: MapCameraPosition

    //Body
    var body: some View{
        
        Map(position: $location){
            ForEach(places, id: \.self) { place in
                ForEach(place.features, id: \.self) { place in
                    //TODO: Fiks kordinatene
                    Annotation(place.properties.name, coordinate: CLLocationCoordinate2D(latitude: place.properties.lat, longitude: place.properties.lon)){
                        Button {
                            //
                        } label: {
                            BeaconPinView()
                        }

                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}


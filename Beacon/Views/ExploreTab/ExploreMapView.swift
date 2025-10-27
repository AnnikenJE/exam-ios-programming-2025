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
        HStack() {
            Spacer()
            VStack{
                Spacer()
                // GPS Button
                Button {
                    // TODO: hente faktisk brukeren sin informasjon
                    location = .region(MKCoordinateRegion.init(center: .init(latitude: 59.9111, longitude: 10.7503), span: .init(latitudeDelta: 0.03, longitudeDelta: 0.03)))
                } label: {
                    Image(systemName: "location.fill")
                        .font(.system(size: 20, weight: .bold))
                }
                .buttonStyleModifier()
                .padding()
            }
        }
    }
}


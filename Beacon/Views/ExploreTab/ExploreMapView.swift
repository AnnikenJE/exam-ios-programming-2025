//
//  MapView.swift
//  Beacon
//
// Kandidatnr 97

import SwiftUI
import MapKit
import SwiftData

struct ExploreMapView: View {
    
    // State object
    @ObservedObject var LocationViewModel: LocationViewModel
    
    // Bindings
    @Binding var places: [Places]
    @Binding var location: MapCameraPosition
    @Binding var latitude: Double
    @Binding var longitude: Double
    @Binding var translatedCategory: String
    
    // States
    @State private var selectedPlace: Feature? = nil
    @State private var isSheetPresented = false

    // Functions
    func updateUserLocation() {
        LocationViewModel.requestLocation()
        print(LocationViewModel.authorizationStatus)
        print(LocationViewModel.locationString)

        if let userlocation = LocationViewModel.location?.coordinate {
            latitude = userlocation.latitude
            longitude = userlocation.longitude
        }
    }
    
    // --------------------------------------- Body
    var body: some View {
        NavigationStack{
            ZStack {
                Map(position: $location){
                    
                    ForEach(places, id: \.self) { place in
                        ForEach(place.features, id: \.self) { place in
                            
                            Annotation(place.properties.name, coordinate: CLLocationCoordinate2D(latitude: place.properties.lat, longitude: place.properties.lon)){
                                Button {
                                    selectedPlace = place
                                    isSheetPresented = true
                                } label: {
                                    Image("pin1")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                }
                            }
                        }
                    }
                } // End Map
                //TODO: FORKLARE + KILDE
                .onMapCameraChange { location in
                    latitude = location.region.center.latitude
                    longitude = location.region.center.longitude
                }
                .sheet(isPresented: $isSheetPresented){
                    PlaceDetailsView(place: $selectedPlace, translatedCategory: $translatedCategory)
                }
                .ignoresSafeArea()
                .onAppear{
                    // Updating camera location
                    location = .region(MKCoordinateRegion.init(center: .init(latitude: latitude, longitude: longitude), span: .init(latitudeDelta: 0.03, longitudeDelta: 0.03)))
                }
                
                HStack() {
                    Spacer()
                    
                    VStack{
                        Spacer()
                        
                        // GPS Button
                        Button {
                            updateUserLocation()
                            location = .region(MKCoordinateRegion.init(center: .init(latitude: latitude, longitude: longitude), span: .init(latitudeDelta: 0.03, longitudeDelta: 0.03)))
                        } label: {
                            Image(systemName: "location.fill")
                                .font(.system(size: 20, weight: .bold))
                        } // End Button label
                        .buttonStyleModifier()
                        .padding()
                    }
                }
            }
        }// End NavigationStack
    }
}


//
//  MapView.swift
//  Beacon
//
// Kandidatnr 97

// View for explore tab. Responsibility: Map.

import SwiftUI
import MapKit
import SwiftData

struct ExploreMapView: View {
    
    // State object
    @StateObject var LocationViewModel: LocationViewModel
    
    // Variables
    var places: [Places]
    
    // Bindings
    @Binding var location: MapCameraPosition
    @Binding var latitude: Double
    @Binding var longitude: Double
    @Binding var translatedCategory: String
    
    // States
    @State private var selectedPlace: Feature? = nil
    @State private var isSheetPresented = false
    
    // Querys
    @Query private var allSavedPlaces: [SavedPlace]
    
    // Functions
    func updateUserLocation() {
        LocationViewModel.requestLocation()
        if let userlocation = LocationViewModel.location?.coordinate {
            latitude = userlocation.latitude
            longitude = userlocation.longitude
        }
        print(LocationViewModel.locationString)
    }
        
    // --------------------------------------- Body
    var body: some View {
        NavigationStack {
            ZStack {
                Map(position: $location) {
                    ForEach(places, id: \.self) { place in
                        ForEach(place.features, id: \.self) { place in
                            let matchingPlace = allSavedPlaces.first{ saved in
                                saved.name == place.properties.name
                            }
                            let ratingsToInt = matchingPlace?.ratings.map { $0.stars} ?? []
                            
                            Annotation(place.properties.name, coordinate: CLLocationCoordinate2D(latitude: place.properties.lat, longitude: place.properties.lon)) {
                                VStack {
                                    if !ratingsToInt.isEmpty{
                                            AverageStarRatingView(stars: ratingsToInt)
                                                .offset(x: 0, y: 15)
                                    }
                                } // End VStack
                                Button {
                                    selectedPlace = place
                                    isSheetPresented = true
                                } label: {
                                    Image("pin1")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                }
                            } // End Annotation
                        } // End ForEach
                    } // End ForEach
                } // End Map
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
                    VStack {
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
                    } // End VStack
                } // End HStack
            } // End ZStack
        } // End NavigationStack
    } // End Body
}


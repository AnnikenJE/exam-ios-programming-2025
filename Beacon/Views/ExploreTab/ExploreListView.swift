//
//  ExploreListView.swift
//  Beacon
//
// Kandidatnr 97

import SwiftUI
import SwiftData

struct ExploreListView: View {
    
    // Variables
    var places: [Places]
    
    // Functions from parent
    var getDataFromAPI: () async -> Void
    
    // Bindings
    @Binding var translatedCategory: String
    
    // States
    @State private var isSheetPresented = false
    @State private var selectedPlace: Feature? = nil
    
    // Querys
    @Query private var allSavedPlaces: [SavedPlace]
    
    // --------------------------------------- Body
    var body: some View {
        NavigationStack {
            
            if (places.isEmpty){
                Text("Ingen steder funnet.")
            } else {
                List(places, id: \.self){ place in
                    ForEach(place.features, id: \.self) { feature in
                        
                        let matchingPlace = allSavedPlaces.first{ saved in
                            saved.name == feature.properties.name
                        }
                        
                        let ratingsToInt = matchingPlace?.ratings.map { $0.stars} ?? []
                        
                        Button{
                            selectedPlace = feature
                            isSheetPresented = true
                        } label: {
                            VStack{
                                HStack{
                                    Text("Navn")
                                        .foregroundStyle(Color.gray)
                                    Spacer()
                                    Text(feature.properties.name)
                                        .font(.headline)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack{
                                    Text("Adresse")
                                        .foregroundStyle(Color.gray)
                                    Spacer()
                                    Text(feature.properties.addressLine)
                                        .font(.subheadline)
                                        .multilineTextAlignment(.trailing)
                                }
                                HStack{
                                    Text("Rating")
                                        .foregroundStyle(Color.gray)
                                    Spacer()
                                    VStack{
                                        if !ratingsToInt.isEmpty{
                                            AverageStarRatingView(stars: ratingsToInt)
                                                .offset(x: 0, y: 15)
                                                .padding(.bottom, 20)
                                                .padding(.trailing, 10)
                                        } else {
                                            Text("Ingen rating.")
                                                .font(.subheadline)
                                                .foregroundStyle(Color.gray)
                                        }
                                    }
                                }
                            }
                        }
                    } // End ForEach
                }   // End List
                
                .sheet(isPresented: $isSheetPresented){
                    PlaceDetailsView(place: $selectedPlace, translatedCategory: $translatedCategory)
                }
                .padding(.top, 60)
                .refreshable {
                    
                    try? await Task.sleep(for: .milliseconds(500))
                    Task{
                        await getDataFromAPI()
                    }
                }
            }
        } // End NavigationStack
    } // End View
}


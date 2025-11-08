//
//  ExploreListView.swift
//  Beacon
//
// Kandidatnr 97

import SwiftUI

struct ExploreListView: View {
    
    // Bindings
    @Binding var places: [Places]
    @Binding var translatedCategory: String
    
    // States
    @State private var isSheetPresented = false
    @State private var selectedPlace: Feature? = nil
    
    // --------------------------------------- Body
    var body: some View {
        NavigationStack {
            
            if (places.isEmpty) {
                //TODO: Gjøre at den viser feks resturant og ikke steder
                Text("Vennligst oppdater for å vise steder.")
                    .foregroundStyle(Color.gray)
            } else {
                List(places, id: \.self){ place in
                    ForEach(place.features, id: \.self) { feature in
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
                            }
                        }
                    } // End ForEach
                }   // End List
                .sheet(isPresented: $isSheetPresented){
                    PlaceDetailsView(place: $selectedPlace, translatedCategory: $translatedCategory)
                }
                .padding(.top, 60)
            }
        } // End NavigationStack
    } // End View
}


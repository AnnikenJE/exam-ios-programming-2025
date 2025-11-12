//
//  MyPlacesView.swift
//  Beacon
//
// Kandidatnr 97

// View for My Places (Mine Steder) Tab.

import SwiftUI
import SwiftData

struct MyPlacesView: View {
    
    // Querys
    @Query private var allSavedPlaces: [SavedPlace]
    
    // Enviroments
    @Environment(\.modelContext) private var modelContext
    
    // --------------------------------------- Body
    var body: some View {
        NavigationStack {
            ScrollView {
                // Section for places
                Section {
                    ForEach(allSavedPlaces) { place in
                        HStack{
                            Spacer()
                            Text(place.name)
                                .font(.headline.bold())
                                .padding()
                            AverageStarRatingView(stars: place.ratings.map { $0.stars})
                                .padding()
                            Spacer()
                        }
                        // Section for ratings
                        Section {
                            ForEach(place.ratings){ rating in
                                HStack(){
                                    Spacer()
                                    Text("Date: \(rating.date.formatted(.dateTime.day().month().year()))")
                                    Spacer()
                                    Text("\(rating.stars) stars")
                                    Image(systemName: "star.fill")
                                        .foregroundStyle(Color.beaconOrange)
                                    Spacer()
                                } // End HStack
                                .padding(10)
                                .background(Color.accentColor.opacity(0.3))
                                .frame(maxWidth: 300)
                                .cornerRadius(18)
                                
                           } // End ForEach
                        } // End Section
                    } // End ForEach
                } // End Section
            } // End ScrollView
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Mine Steder")
                        .headingStyleModifier()
                }
            } // End Toolbar
        } // End NavigationStack
    } // End Body
}

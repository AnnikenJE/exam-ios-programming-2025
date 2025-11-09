//
//  MyPlacesView.swift
//  Beacon
//

import SwiftUI
import SwiftData

//TODO: Legge til delete + PlaceDetailsView

struct MyPlacesView: View {
    
    // Querys
    @Query private var allSavedPlaces: [SavedPlace]
    
    // Enviroments
    @Environment(\.modelContext) private var modelContext
    
    // States
    //    @State private var isSheetPresented = false
    //    @State private var selectedPlace: SavedPlace? = nil
    
    // --------------------------------------- Body
    var body: some View {
        NavigationStack{
            ScrollView{
                Section(header: Text("Mine rangerte steder")){
                    ForEach(allSavedPlaces) { place in
                        Button(place.name){
//                            isSheetPresented = true
//                            selectedPlace = place
                        }
                        
                        Section("Rangeringer"){
                            ForEach(place.ratings){ rating in
                                HStack{
                                    Spacer()
                                    Text(rating.date.formatted(.dateTime.day().month().year()))
                                    Spacer()
                                    Text("\(rating.stars)")
                                    Spacer()
                                }
                            }
                        }
                    }
                    .navigationTitle("Mine steder")
//                    .sheet(isPresented: $isSheetPresented){
//                        PlaceDetailsView(place: $selectedPlace)
//                    }
                }
            }
        }
    }
}

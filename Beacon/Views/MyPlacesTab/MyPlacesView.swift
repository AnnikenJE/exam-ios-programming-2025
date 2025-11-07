//
//  MyPlacesView.swift
//  Beacon
//

import SwiftUI
import SwiftData

struct MyPlacesView: View {
    
    // Querys
    @Query private var allSavedPlaces: [SavedPlace]

    // Enviroments
    @Environment(\.modelContext) private var modelContext
    
    // States
    @State private var isSheetPresented = false
    
    //TODO: Legge til delete?

    
    // --------------------------------------- Body
    var body: some View {
        NavigationStack{
            ScrollView{
                Section(header: Text("Mine rangerte steder")){
                    ForEach(allSavedPlaces) { place in
                        Text(place.name)
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
                }
            }
        }
    }
}


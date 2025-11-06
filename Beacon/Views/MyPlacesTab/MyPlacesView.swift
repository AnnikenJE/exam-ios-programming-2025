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
    
    
    //TODO: try catch
    private func onDeletePlace(at offsets: IndexSet) {
        for offset in offsets {
            let place = allSavedPlaces[offset]
            modelContext.delete(place)
        }
    }
    
    private func onDeleteRating(at offsets: IndexSet) {
        for offset in offsets {
            let place = allSavedPlaces[offset]
            modelContext.delete(place)
        }
    }
    
    // --------------------------------------- Body
    var body: some View {
        NavigationStack{
            List{
                Section(header: Text("Mine rangerte steder")){
                    ForEach(allSavedPlaces) { place in
                        Text(place.name)
                        ForEach(place.ratings){ rating in
                            Text("\(rating.stars)")
                        }
                        
                    }
                    .navigationTitle("Mine steder")
                }
            }
            .onDelete
          
        }

    }
}

// --------------------------------------- Preview


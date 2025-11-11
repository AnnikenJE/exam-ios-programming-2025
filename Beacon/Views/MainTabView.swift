//
//  TabView.swift
//  Beacon
//
// Kandidatnr 97

// Tab bar

import SwiftUI
import SwiftData

struct MainTabView: View {
    
    // --------------------------------------- Body
    var body: some View {
        TabView{
            ExploreView(locationViewModel: LocationViewModel())
                .tabItem {
                    Label("Utforsk", systemImage: "map")
                }
            MyPlacesView()
                .tabItem{
                    Label("Mine steder", systemImage: "pin")
                }
        } // End TabView
        .modelContainer(for: [SavedPlace.self, Rating.self])
        .tint(Color.beaconOrange)
    } // End Body
}

// --------------------------------------- Preview
#Preview {
    MainTabView()
}

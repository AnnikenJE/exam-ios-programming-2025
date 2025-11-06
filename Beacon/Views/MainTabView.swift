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
            ExploreView(viewModel: LocationViewModel())
                .tabItem {
                    Label("Utforsk", systemImage: "map")
                }
            MyPlacesView()
                .tabItem{
                    Label("Mine steder", systemImage: "pin")
                }
        }
        .modelContainer(for: [SavedPlace.self, Rating.self])
        .tint(Color.beaconOrange)
    }
}

// --------------------------------------- Preview
#Preview {
    MainTabView()
}

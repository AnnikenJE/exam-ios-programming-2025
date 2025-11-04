//
//  TabView.swift
//  Beacon
//
// Kandidatnr 97

import SwiftUI

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
        .tint(Color.beaconOrange)
    }
}

#Preview {
    MainTabView()
}

//
//  TabView.swift
//  Beacon
//

import SwiftUI

struct MainTabView: View {
    
    // Body
    var body: some View {
        TabView{
            ExploreView()
                .tabItem {
                    Label("Utforsk", systemImage: "map")
                }
            MyPlacesView()
                .tabItem{
                    Label("Mine steder", systemImage: "pin")
                }
        }
        .tint(Colors.beaconOrange)
        
    }
}

#Preview {
    MainTabView()
}

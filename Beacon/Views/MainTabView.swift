//
//  TabView.swift
//  Beacon
//

import SwiftUI

struct MainTabView: View {
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
    }
}

#Preview {
    MainTabView()
}

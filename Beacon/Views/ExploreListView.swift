//
//  ExploreListView.swift
//  Beacon
//

import SwiftUI

struct ExploreListView: View {
    
    @Binding var places: [Places]
    
    var body: some View {
        List(places, id: \.self) { place in
            ForEach(place.features, id: \.self) { feature in
                Text(feature.properties.name)
            }
        }
    }
}



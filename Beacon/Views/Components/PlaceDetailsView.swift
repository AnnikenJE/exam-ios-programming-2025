//
//  PlaceDetailsView.swift
//  Beacon
//

import SwiftUI

struct PlaceDetailsView: View {
    
    //Enviroments
    @Environment(\.dismiss) private var dismiss
    
    //Bindings
    @Binding var place: Feature?
    
    var body: some View {
        VStack{
            Text(place?.properties.name ?? "Kunne ikke vise navn")
        }
    }
}

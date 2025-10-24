//
//  ContentView.swift
//  Beacon
//


import SwiftUI
import MapKit

struct ExploreView: View {
    
    // Default location on startup, Oslo Central Station
    @State private var location: MapCameraPosition = .region(
        MKCoordinateRegion(center:
                            CLLocationCoordinate2D(latitude: 59.9111, longitude: 10.7503),
                           span:
                            MKCoordinateSpan.init(latitudeDelta: 0.003, longitudeDelta: 0.003)))
    
    var body: some View {
        ZStack {
            Map(position: $location){
                
                
            }
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack{
                    Spacer(minLength: 325)
                    Button {
                        
                        //TODO:
                        location = .region(MKCoordinateRegion.init(center: .init(latitude: 50, longitude: 10), span: .init(latitudeDelta: 0.03, longitudeDelta: 0.03)))
                    } label: {
                        Image(systemName: "person")
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ExploreView()
}

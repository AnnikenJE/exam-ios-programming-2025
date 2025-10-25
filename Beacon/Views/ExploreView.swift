//
//  ContentView.swift
//  Beacon
//

import SwiftUI
import MapKit

struct ExploreView: View {
    
    //TODO: Try (do) catches
    // States
    @State private var selectedCategory = "?????"
    @State private var isMapShowing = true
    @State private var places: [Places] = []
    @State private var errorMessage: String? = nil
    @State private var category = "catering.restaurant"
    //TODO: trenger en bedre løsning her
    // Default location on startup, Oslo Central Station
    @State private var location: MapCameraPosition = .region(
        MKCoordinateRegion(center:
                            CLLocationCoordinate2D(latitude: 59.9111, longitude: 10.7503),
                           span:
                            MKCoordinateSpan.init(latitudeDelta: 0.003, longitudeDelta: 0.003)))
    
    func getDataFromAPI() async {
        // URL
        do {
            let APIkey = APIKey.geoapifyAPIKey
            // TODO: Fjerne ! ?
            let url = URL(string: "https://api.geoapify.com/v2/places?categories=\(category)&filter=circle:10.7461,59.9127,1000&limit=10&apiKey=\(APIkey)")!
            let (data, response) = try await URLSession.shared.data(from: url)
            let places = try JSONDecoder().decode(Places.self, from: data)
            self.places = [places]
            print("Hentet")
        } catch {
            errorMessage = "Something went wrong when getting data from API. \(error.localizedDescription)"
            print(errorMessage)
        }
    }
    
    //Body 
    var body: some View {
        ZStack {
            
            // Toggle between map and list
            if(isMapShowing) {
                ExploreMapView(places: $places)
            } else {
                ExploreListView(places: $places)
            }
            
            VStack {
                HStack {
                    Picker("Kategori", selection: $selectedCategory){
                        Text("?").tag("?????")
                        Text("?").tag("list")
                    }.pickerStyle(.segmented)
                    
                    Button {
                        Task {
                            await getDataFromAPI()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                HStack {
                    Spacer()
                    Toggle(isOn: $isMapShowing){
                        Text("Show map")
                    }
                }
                
                Spacer()
                
                HStack {
                    Spacer(minLength: 325)
                    Button {
                        //TODO: må gjøre noe med dette
                        location = .region(MKCoordinateRegion.init(center: .init(latitude: 50, longitude: 10), span: .init(latitudeDelta: 0.03, longitudeDelta: 0.03)))
                    } label: {
                        Image(systemName: "person")
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                } // End HStack
            } // End VStack
        } // End ZStack
    } // End body
}

#Preview {
    ExploreView()
}

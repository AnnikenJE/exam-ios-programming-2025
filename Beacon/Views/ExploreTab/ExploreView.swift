//
//  ContentView.swift
//  Beacon
//

import SwiftUI
import MapKit
import SwiftData

struct ExploreView: View {
    
    //TODO: Try (do) catches, husk på database også
    
    // Enum
    enum Category {
        case restaurant
        case cafe
        case hotel
    }
    
    //Enviroments
    @Environment(\.modelContext) private var ModelContext
    
    //Query
    @Query private var mapLocation: [MapLocation]
    
    // States
    @State private var category = "caatering.resturant"
    @State private var selectedCategory: Category = .restaurant
    @State private var isMapShowing = true
    @State private var places: [Places] = []
    @State private var errorMessage: String? = nil
    
    // Default location on startup, Oslo Central Station 59.9111 10.7503
    @State private var location: MapCameraPosition = .region(
        MKCoordinateRegion(center:
                            CLLocationCoordinate2D(latitude: 59.9111, longitude: 10.7503),
                           span:
                            MKCoordinateSpan.init(latitudeDelta: 0.003, longitudeDelta: 0.003)))
    
    func getDataFromAPI() async {
        // URL
        do {
            getCategory()
            let APIkey = APIKey.geoapifyAPIKey
            // TODO: Fjerne utropstegn i url ?
            let url = URL(string: "https://api.geoapify.com/v2/places?categories=\(category)&filter=circle:10.7461,59.9127,1000&limit=10&apiKey=\(APIkey)")!
            print(url)
            let (data, response) = try await URLSession.shared.data(from: url)
            let places = try JSONDecoder().decode(Places.self, from: data)
            self.places = [places]
            print("Hentet")

        } catch {
            errorMessage = "Something went wrong when getting data from API. \(error.localizedDescription)"
            print(errorMessage)
        }
    }
    
    func getCategory() {
        if (selectedCategory == .cafe){
            category = "catering.cafe"
        } else if (selectedCategory == .hotel){
            category = "accommodation.hotel"
        } else {
            category = "catering.restaurant"
        }
    }
        
        // Body
        var body: some View {
            ZStack {
                
                // Swap between map and list
                if(isMapShowing) {
                    ExploreMapView(places: $places, location: $location)
                } else {
                    ExploreListView(places: $places)
                }
                
                VStack {
                    HStack {
                        
                        // Picker for categories
                        Picker("Kategori", selection: $selectedCategory){
                            Text("Resturant").tag(Category.restaurant)
                            Text("Hotell").tag(Category.hotel)
                            Text("Kafé").tag(Category.cafe)
                        }
                        .pickerStyle(.segmented)
                        
                        // Get places nearby button
                        Button {
                            Task {
                                await getDataFromAPI()
                            }
                        } label: {
                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 20, weight: .bold))
                        }
                        .buttonStyleModifier()
                    }
                    HStack {
                        Spacer()
                        
                        // Toggle for showing map or list
                        Toggle(isMapShowing ? "Show List" :"Show Map", systemImage: isMapShowing ? "list.dash" : "map.fill", isOn: $isMapShowing)
                            .toggleStyle(.button)
                            .contentTransition(.symbolEffect)
                            .background(Colors.deepBlue)
                            .cornerRadius(18)
                    }
                    Spacer()
                }
                .padding()
            }
        } // End body
    }
    
    #Preview {
        ExploreView()
    }

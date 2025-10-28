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
    
    // Enviroments
    @Environment(\.modelContext) private var ModelContext
    
    // Query
    @Query private var mapLocation: [MapLocation]
    
    // Variables
    private var lastUserLocation: MapLocation {
        mapLocation.last(where: { $0.position == "user" }) ??
        MapLocation(position: "user", longitude: 10.7503, latitude: 59.9111)
    }
    
    // States
    @State private var category = "catering.resturant"
    @State private var selectedCategory: Category = .restaurant
    @State private var isMapShowing = true
    @State private var places: [Places] = []
    @State private var errorMessage: String? = nil
    
    // Default location on startup, Oslo Central Station 59.9111 10.7503
    @State private var location: MapCameraPosition = .region(
        MKCoordinateRegion(center:
                            CLLocationCoordinate2D(latitude: 10.7503 , longitude: 59.9111),
                           span:
                            MKCoordinateSpan.init(latitudeDelta: 0.003, longitudeDelta: 0.003)))
    

    
    func getDataFromAPI() async {
        // TODO: Fiks rotet u denne
        do {
            updateLastUserLocation()
            getCategory()
            
            let APIkey = APIKey.geoapifyAPIKey
            // TODO: Fjerne utropstegn i url ?
            let url = URL(string: "https://api.geoapify.com/v2/places?categories=\(category)&filter=circle:\(lastUserLocation.longitude),\(lastUserLocation.latitude),1000&limit=10&apiKey=\(APIkey)")!
            // TODO: Slett print
            print(url)
            let (data, response) = try await URLSession.shared.data(from: url)
            let places = try JSONDecoder().decode(Places.self, from: data)
            self.places = [places]
            print("Getting data from API successfull.")
            
            //TODO: REMOVE
            print(lastUserLocation.latitude, lastUserLocation.longitude, lastUserLocation, lastUserLocation.position)
        } catch {
            errorMessage = "Something went wrong in getDataFromAPI(). \(error.localizedDescription)"
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
    
    func updateLastUserLocation(){
        do {
            let userLocation = MapLocation(position: "user",longitude: 10.7503, latitude: 59.9111)
            ModelContext.insert(userLocation)
            try ModelContext.save()
        } catch {
            errorMessage = "Something went wrong in updateLastUserLocation(). \(error.localizedDescription)"
            print(errorMessage)
        }
    }
    
    // --------------------------------------- Body
    var body: some View {
        ZStack {
            // Swap between map and list
            if(isMapShowing) {
                ExploreMapView(places: $places, location: $location, lastUserLocation: lastUserLocation)
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
                    } // End Picker
                    .pickerStyle(.segmented)
                    .background(Color.beaconOrange)
                    .cornerRadius(18)
                    
                    // Get places nearby button
                    Button {
                        Task {
                            await getDataFromAPI()
                            updateLastUserLocation()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 20, weight: .bold))
                    } // End Button label
                    .buttonStyleModifier()
                }
                
                HStack {
                    Spacer()

                    // Toggle for showing map or list
                    Toggle(isMapShowing ? "Show List" :"Show Map", systemImage: isMapShowing ? "list.dash" : "map.fill", isOn: $isMapShowing)
                        .toggleStyle(.button)
                        .contentTransition(.symbolEffect)
                        .background(Color.deepBlue)
                        .cornerRadius(18)
                }
                Spacer()
            }
            .padding()
        } // End ZStack
    } // End body
}

#Preview {
    ExploreView()
}

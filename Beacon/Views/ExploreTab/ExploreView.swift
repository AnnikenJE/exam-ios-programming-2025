//
//  ContentView.swift
//  Beacon
//
// Kandidatnr 97

import SwiftUI
import MapKit
import SwiftData

struct ExploreView: View {
    
    // AppStorage
    @AppStorage("latitude") private var latitude = 59.9111
    @AppStorage("longitude") private var longitude = 10.7503

    // Enum
    enum Category {
        case restaurant
        case cafe
        case hotel
    }
    
    // Enviroments (ikke brukt enda), må muligens fjernes om den ikke blir brukt
    //@Environment(\.modelContext) private var ModelContext
    
    // Query
    // @Query private var mapLocation: [MapLocation] Denne skal ikke brukes men har den til eksempel senere
    
    // States
    @State private var category = "catering.resturant"
    @State private var selectedCategory: Category = .restaurant
    @State private var isMapShowing = true
    @State private var places: [Places] = []
    @State private var errorMessage: String? = nil
    @State private var isLoading = false
    @State private var translatedCategory = "Restaurant"
    
    // Default location on startup, Oslo Central Station 59.9111 10.7503
    @State private var location: MapCameraPosition = .region(
        MKCoordinateRegion(center:
                            CLLocationCoordinate2D(latitude: 59.9111 , longitude: 10.7503),
                           span:
                            MKCoordinateSpan.init(latitudeDelta: 0.003, longitudeDelta: 0.003)))
    
    func getDataFromAPI() async {
        // TODO: Fiks rotet u denne
        do {
            isLoading = true
            errorMessage = nil
            getCategory()
            
            let APIkey = APIKey.geoapifyAPIKey
            // TODO: Fjerne utropstegn i url, det kan kræsje
            let url = URL(string: "https://api.geoapify.com/v2/places?categories=\(category)&filter=circle:\(longitude),\(latitude),1000&limit=10&apiKey=\(APIkey)")!
            // TODO: Slett print
            print(url)
            let (data, response) = try await URLSession.shared.data(from: url)
            let places = try JSONDecoder().decode(Places.self, from: data)
            self.places = [places]
            print("Getting data from API successfull.")
            
            //TODO: REMOVE
            print(latitude, longitude)
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = "Something went wrong in getDataFromAPI(). \(error.localizedDescription)"
            print(errorMessage ?? "Noe gikk galt i getDataFromAPI().")
        }
    }
    
    func getCategory() {
        if (selectedCategory == .cafe){
            category = "catering.cafe"
            translatedCategory = "Kafé"
        } else if (selectedCategory == .hotel){
            category = "accommodation.hotel"
            translatedCategory = "Hotell"
        } else {
            category = "catering.restaurant"
            translatedCategory = "Restaurant"
        }
    }
    
    // --------------------------------------- Body
    var body: some View {
        NavigationStack {
            ZStack {
                
                //TODO: Gjøre til funksjon?
                if(isLoading){
                    ProgressView("Henter steder...")
                } else {
                    if(isMapShowing) {
                        ExploreMapView(places: $places, location: $location, latitude: $latitude, longitude: $longitude, translatedCategory: $translatedCategory)
                    } else {
                        ExploreListView(places: $places, translatedCategory: $translatedCategory)
                    }
                }
                
                VStack {
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
            .toolbar{
                ToolbarItem(placement: .principal){
                    // Picker for categories
                    Picker("Kategori", selection: $selectedCategory){
                        Text("Resturant").tag(Category.restaurant)
                        Text("Hotell").tag(Category.hotel)
                        Text("Kafé").tag(Category.cafe)
                    } // End Picker
                    .pickerStyle(.segmented)
                    .background(Color.beaconOrange)
                    .presentationCornerRadius(18)
                    .cornerRadius(18)
                }
                
                ToolbarItem(placement: .confirmationAction){
                    // Get places nearby button.
                    Button {
                        Task {
                            await getDataFromAPI()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .buttonStyleModifier()
                    } // End Button label
                    .buttonStyleModifier()
                }
                
                ToolbarItem(placement: .largeTitle){
                    HStack{
                        Image("icon2")
                            .resizable()
                            .frame(width: 55, height: 55)
                        Text("Beacon")
                            .font(.largeTitle.bold())
                            .foregroundStyle(Color.beaconOrange)
                    }
                }
            }
            .toolbarBackground(Color.deepBlue, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for:.navigationBar)
        } // End NavigationView
    } // End body
}

#Preview {
    ExploreView()
}

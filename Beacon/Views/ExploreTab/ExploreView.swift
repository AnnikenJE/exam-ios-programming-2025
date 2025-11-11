//
//  ContentView.swift
//  Beacon
//
// Kandidatnr 97

// View for Explore (Utforsk) tab.

import SwiftUI
import MapKit
import Foundation
import SwiftData

struct ExploreView: View {
    
    // State object
    @StateObject var locationViewModel = LocationViewModel()
    @StateObject var searchViewModel = SearchViewModel()
    
    // AppStorage
    @AppStorage("latitude") private var latitude = 59.9111
    @AppStorage("longitude") private var longitude = 10.7503
    @AppStorage("radius") private var radius = 5000.0
    
    // Enum
    enum Category {
        case restaurant
        case cafe
        case hotel
    }
    
    enum Sorting {
        case noSorting
        case highestRating
        case alphabetical
        case closestDistance
    }
    
    // Querys
    @Query private var allSavedPlaces: [SavedPlace]
    
    // States
    @State private var places: [Places] = []
    @State private var category = "catering.restaurant"
    @State private var translatedCategory = "Restaurant"
    @State private var searchTextInURL = ""
    @State private var errorMessage: String? = nil
    @State private var selectedSorting: Sorting = .noSorting
    @State private var selectedCategory: Category = .restaurant
    @State private var isMapShowing = true
    @State private var isLoading = false
    @State private var isSliding = false
    @State private var isFavouritesSorted = false
    @State private var isSearching = false
    // Default location on startup, Oslo Central Station 59.9111 10.750
    @State private var location: MapCameraPosition = .region(
        MKCoordinateRegion(center:
                            CLLocationCoordinate2D(latitude: 59.9111 , longitude: 10.7503),
                           span:
                            MKCoordinateSpan.init(latitudeDelta: 0.03, longitudeDelta: 0.03)))
    
    // Functions
    func getDataFromAPI() async {
        do {
            isLoading = true
            errorMessage = nil
            
            getCategory()
            generateSearchInURL()
            
            guard let url = URL(string: "https://api.geoapify.com/v2/places?categories=\(category)&filter=circle:\(longitude),\(latitude),\(Int(radius))\(searchTextInURL)&limit=10&apiKey=\(APIKey.geoapifyAPIKey)") else { print("Invalid URL in getDataFromAPI().")
                return
            }
            print(url)
            let (data, _) = try await URLSession.shared.data(from: url)
            let places = try JSONDecoder().decode(Places.self, from: data)
            self.places = [places]
            
            sortPlaces()
            if isFavouritesSorted{
                sortFavourites()
            }
            
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = "Something went wrong in getDataFromAPI(). \(error.localizedDescription)"
            print(errorMessage ?? "No error message.")
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
        isSearching = true
    }
    
    func generateSearchInURL() {
        if !searchViewModel.debouncedText.isEmpty {
            searchTextInURL = "&name=\(searchViewModel.debouncedText)"
        } else {
            searchTextInURL = ""
        }
        isSearching = true
    }
    
    func sortPlaces() {
        isSearching = true
        
        switch(selectedSorting){
                
            case .noSorting:
                return
                
            case .alphabetical:
                let filteredPlaces = places.map{ place in
                    let filteredFeatures = place.features.sorted {
                        $0.properties.name < $1.properties.name
                    }
                    return Places(features: filteredFeatures)
                }
                places = filteredPlaces
                
            case .highestRating:
                
                // TODO: Add sorting by highest rating
               return
                
            case .closestDistance:

                // TODO: Add sorting by closest distance
                return
        }
    }
    
    // If it´s rated then its a favourite. (Even with bad rating :)
    func sortFavourites ()  {
        isSearching = true
        
        let sortedPlaces = places.map{ place in
            let sortedFeatures = place.features.filter{ feature in
                allSavedPlaces.contains(where: {$0.name == feature.properties.name && !$0.ratings.isEmpty})
            }
            return Places(features: sortedFeatures)
        }
        places = sortedPlaces
    }
    
    func clearButton() async {
        searchViewModel.debouncedText = ""
        radius = 5000
        selectedCategory = .restaurant
        selectedSorting = .noSorting
        isFavouritesSorted = false
        isSearching = false
    }
    
    // --------------------------------------- Body
    var body: some View {
        NavigationStack {
            ZStack {
                if(isLoading) {
                    ProgressView("Henter steder...")
                } else {
                    if(isMapShowing) {
                        ExploreMapView(LocationViewModel: locationViewModel, places: places, location: $location, latitude: $latitude, longitude: $longitude, translatedCategory: $translatedCategory)
                    } else {
                        ExploreListView(places: places, translatedCategory: $translatedCategory, getDataFromAPI: getDataFromAPI)
                    }
                }
                
                VStack {
                    HStack {
                        Slider(value: $radius,
                               in: 1000...10000,
                               onEditingChanged: { sliding in
                            isSliding = sliding
                            isSearching = true
                            
                        })
                        .frame(width: 200)
                        
                        Spacer(minLength: 10)
                        
                        Toggle(isMapShowing ? "Show List" :"Show Map", systemImage: isMapShowing ? "list.dash" : "map.fill", isOn: $isMapShowing)
                            .toggleStyle(.button)
                            .contentTransition(.symbolEffect)
                            .background(Color.deepBlue)
                            .cornerRadius(50)
                    } // End HStack
                    
                    HStack {
                        Picker("Filter", selection: $selectedSorting) {
                            Text("Ingen filter").tag(Sorting.noSorting)
                            Text("Alfabetisk").tag(Sorting.alphabetical)
                            Text("Vurdering").tag(Sorting.highestRating)
                            Text("Distanse").tag(Sorting.closestDistance)
                        }
                        .buttonStyleModifier()
                        
                        Button {
                            isFavouritesSorted.toggle()
                            isSearching = true
                        } label: {
                            Image(systemName: isFavouritesSorted ? "star.fill" : "star.slash")
                        }
                        .buttonStyleModifier()
                        Spacer()
                    } // End HStack
                    
                    Spacer()
                    
                } // End VStack
                .padding()
                
            } // End ZStack
            .toolbar {
                ToolbarItem(placement: .principal) {
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
                
                ToolbarItem(placement: .cancellationAction) {
                    if isSearching {
                        Button {
                            Task{
                                await clearButton()
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .buttonStyleModifier()
                        }
                        .buttonStyleModifier()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
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
                
                ToolbarItem(placement: .largeTitle) {
                    HStack{
                        Image("icon2")
                            .resizable()
                            .frame(width: 55, height: 55)
                        Text("Beacon")
                            .font(.largeTitle.bold())
                            .foregroundStyle(Color.beaconOrange)
                    }
                }
            } // End Toolbar
            .toolbarBackground(Color.deepBlue, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for:.navigationBar)
        } // End NavigationStack
        .searchable(text: $searchViewModel.searchText)
        .onChange(of: searchViewModel.debouncedText){ oldText, newText in
            Task{
                await getDataFromAPI()
            }
        }
    } // End body
}

// --------------------------------------- Preview
#Preview {
    ExploreView(locationViewModel: LocationViewModel())
}

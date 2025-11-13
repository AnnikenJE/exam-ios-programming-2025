//
//  PlaceDetailsView.swift
//  Beacon
//
// Kandidatnr 97

// View for showing places details.

import SwiftUI
import SwiftData

struct PlaceDetailsView: View {
    
    // Enviroments
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    @Environment(\.modelContext) private var modelContext
    
    // Bindings
    @Binding var place: Feature?  
    @Binding var translatedCategory: String
 
    // Querys
    @Query private var allSavedPlaces: [SavedPlace]
    
    // States
    @State private var twoStarReview = false
    @State private var threeStarReview = false
    @State private var fourStarReview = false
    @State private var fiveStarReview = false
    @State private var starRating = 1
    @State private var ratingsToInt: [Int] = []
    @State private var isRated = false
    
    // Functions
    func openAppleMaps(){
        guard let url = URL(string: "https://maps.apple.com/?q=\(place?.properties.addressLine ?? "Could not find address in apple maps.")")
        else {
            print("Could not create url for apple maps.")
            return
        }
        openURL(url)
    }
    
    func ratePlace(){
        guard let place = place else {
            print("Place == nil in ratePlace.")
            return
        }
        
        let placeName = place.properties.name
        let placeAddress = place.properties.addressLine
        let placeCategory = translatedCategory
        let placePhone = place.properties.contact?.phone
        let placeEmail = place.properties.contact?.email
        let placeOpeningHours = place.properties.openingHours
        let placeWebsite = place.properties.website
        let placeLon = place.properties.lon
        let placeLat = place.properties.lat
        
        // Check if place exists in database
        let existingPlace = allSavedPlaces.first(where: { saved in
            saved.name == placeName && saved.address == placeAddress})
        
        do {
            let placeToRate: SavedPlace
            
            if let existing = existingPlace {
                placeToRate = existing
            } else {
                let newPlace = SavedPlace(name: placeName, address: placeAddress, ratings: [], category: placeCategory, phone: placePhone, email: placeEmail, openingHours: placeOpeningHours, website: placeWebsite, lon: placeLon, lat: placeLat)
                modelContext.insert(newPlace)
                placeToRate = newPlace
             }
            
            let newRating = Rating(savedPlace: placeToRate, stars: starRating)
            modelContext.insert(newRating)
            try modelContext.save()
            
        } catch {
            print("Could not rate place and put into database: \(error)")
        }
    }
    
    func findPlaceRatingsInDatabase() {
        let matchingPlace = allSavedPlaces.first{ saved in
            saved.name == place?.properties.name
        }
        ratingsToInt = matchingPlace?.ratings.map { $0.stars} ?? []
    }
    
    // --------------------------------------- Body
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    // Information section
                    Section("Informasjon"){
                        HStack {
                            Text("Vurdering")
                                .foregroundStyle(Color(.gray))
                            Spacer()
                            if !ratingsToInt.isEmpty{
                                    AverageStarRatingView(stars: ratingsToInt)
                                    .offset(x: 0, y: 15)
                                    .padding(.bottom, 20)
                                    .padding(.trailing, 10)
                            } else{
                                Text("Ingen vurderinger.")
                            }
                        } // End HStack
                        
                        HStack {
                            Text("Kategori")
                                .foregroundStyle(Color(.gray))
                            Spacer()
                            Text(translatedCategory)
                        } // End HStack
                        
                        HStack {
                            Text("Adresse")
                                .foregroundStyle(Color(.gray))
                            Spacer()
                            Text(place?.properties.addressLine ?? "Ingen adresse.")
                        } // End HStack
                        
                        HStack {
                            Text("Telefonnummer")
                                .foregroundStyle(Color(.gray))
                            Spacer()
                            Text(place?.properties.contact?.phone ?? "Ingen telefonnummer.")
                        } // End HStack
                        
                        HStack {
                            Text("Åpningstider")
                                .foregroundStyle(Color(.gray))
                            Spacer()
                            Text(place?.properties.openingHours ?? "Ingen åpningstider.")
                        } // End HStack
                        
                        HStack {
                            Text("Nettside")
                                .foregroundStyle(Color(.gray))
                            Spacer()
                            if let website = place?.properties.website{
                                if let url = URL(string: website){
                                    Link(website, destination: url)
                                } else {
                                    Text("Ingen nettside.")
                                }
                            } else {
                                Text("Ingen nettside.")
                            }
                        } // End HStack
                        
                        HStack {
                            Text("Koordinater")
                                .foregroundStyle(Color(.gray))
                            Spacer()
                            Text("latitude \(place?.properties.lat ?? 0.0), \nlongitude \(place?.properties.lon ?? 0.0)")
                        } // End HStack
                        
                        Button {
                            openAppleMaps()
                        } label: {
                            Text("Åpne i Maps")
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                        }
                        .buttonStyleModifier()
                    } // End Section
                } // End Form
                
                // Rating Section
                Section("Gi din vurdering!"){
                    VStack {
                        HStack(spacing: 15){
                            Button {
                                twoStarReview = false
                                threeStarReview = false
                                fourStarReview = false
                                fiveStarReview = false
                                starRating = 1
                            } label: {
                                Image(systemName: "star.fill")
                            }
                            .foregroundStyle(.highlightOrange)
                            
                            Button {
                                twoStarReview = true
                                threeStarReview = false
                                fourStarReview = false
                                fiveStarReview = false
                                starRating = 2
                            } label: {
                                Image(systemName: twoStarReview ? "star.fill" : "star")
                            }
                            .foregroundStyle(.highlightOrange)
                            
                            Button {
                                twoStarReview = true
                                threeStarReview = true
                                fourStarReview = false
                                fiveStarReview = false
                                starRating = 3
                            } label: {
                                Image(systemName: threeStarReview ? "star.fill" : "star")
                            }
                            .foregroundStyle(.highlightOrange)
                            
                            Button {
                                twoStarReview = true
                                threeStarReview = true
                                fourStarReview = true
                                fiveStarReview = false
                                starRating = 4
                            } label: {
                                Image(systemName: fourStarReview ? "star.fill" : "star")
                            }
                            .foregroundStyle(.highlightOrange)
                            
                            Button {
                                twoStarReview = true
                                threeStarReview = true
                                fourStarReview = true
                                fiveStarReview = true
                                starRating = 5
                            } label: {
                                Image(systemName: fiveStarReview ? "star.fill" : "star")
                            }
                            .foregroundStyle(.highlightOrange)
                            
                            Button{
                                ratePlace()
                                findPlaceRatingsInDatabase()
                                isRated.toggle()
                            }
                            label: {
                                Image(systemName: "plus")
                            }
                            .alert(isPresented: $isRated){
                                Alert(title: Text(place?.properties.name ?? "Kunne ikke vise navn."), message: Text("Takk for din tilbakemelding"))
                            }
                            .buttonStyleModifier()
                        } // End HStack with stars
                    } // End VStack
                    .padding()
                } // End Section
            } // End VStack
            
            // Toolbar
            .toolbar{
                ToolbarItem(placement: .largeTitle) {
                    Text(place?.properties.name ?? "Kunne ikke vise navn.")
                        .headingStyleModifier()
                } // End ToolbarItem
                
                ToolbarItem(placement: .principal){
                    switch(translatedCategory){
                        case "Restaurant":
                            ResturantAnimationView()
                        case "Kafé":
                            CafeAnimationView()
                        case "Hotell":
                            HotelAnimationView()
                        default:
                            CafeAnimationView()
                    }
                } // End ToolbarItem
                
                ToolbarItem(placement: .confirmationAction) {
                    Button{
                        dismiss()
                    }label: {
                        Image(systemName:"xmark")
                            .foregroundStyle(Color.white)
                    }
                    .buttonStyleModifier()
                } // End ToolbarItem
            } // End .toolbar
        } // End navigationStack
        .onAppear{
            findPlaceRatingsInDatabase()
        }
    } // End body
}

// --------------------------------------- Preview
#Preview {
    PlaceDetailsView(
        place: .constant(
            Feature(
                properties:
                    Properties(name: "Resturant Navn", addressLine: "Adresse Adresse 23", lat: 23.12412, lon: 41.24232, openingHours: "10:00-18:00", website: "www.test.com", contact: Contact(phone: "+2324332", email: "test@test.no")
                              )
            )
        ),
        translatedCategory: .constant("category")
    )
}

//
//  PlaceDetailsView.swift
//  Beacon
//
// Kandidatnr 97

// View for showing places details

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
    @State private var oneStarReview = false
    @State private var twoStarReview = false
    @State private var threeStarReview = false
    @State private var fourStarReview = false
    @State private var fiveStarReview = false
    @State private var starRating = 0
    
    
    // Functions
    // TODO: Kilde
    func openAppleMaps(){
        if let url = URL(string: "https://maps.apple.com/?q=\(place?.properties.addressLine ?? "Kunne ikke vise adresse")") {
            openURL(url)
        }
    }
    
    
    
    func ratePlace(){
        
        if place == nil{
            print("Place == nil")
            return
        }
        
        let placeName = place?.properties.name ?? "Ingen navn."
        let placeAdress = place?.properties.addressLine ?? "Ingen adresse"
        
        let existingPlace = allSavedPlaces.first(where: { saved in
            saved.name == placeName && saved.adress == placeAdress})
        
        do {
            
            let newPlaceToRate: SavedPlace
            
            if let existing = existingPlace {
                newPlaceToRate = existing
                
                print("existing place:", existing.name)
            } else {
                let newPlace = SavedPlace(name: placeName, adress: placeAdress, ratings: [])
                modelContext.insert(newPlace)
                newPlaceToRate = newPlace
                

                print("new place:", newPlace.name)
            
             }
            
            let newRating = Rating(savedPlace: newPlaceToRate, stars: starRating)
            modelContext.insert(newRating)
            
            try modelContext.save()
            
        } catch {
            print("Could not rate place and put into database: \(error)")
        }
    }
    
    // --------------------------------------- Body
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    // Section
                    Section("Informasjon"){
                        HStack{
                            Text("Kategori")
                                .foregroundStyle(Color(.gray))
                            Spacer()
                            Text(translatedCategory)
                        }
                        
                        HStack{
                            Text("Adresse")
                                .foregroundStyle(Color(.gray))
                            Spacer()
                            Text(place?.properties.addressLine ?? "Kunne ikke vise adresse")
                        }
                        
                        HStack{
                            Text("Telefonnummer")
                                .foregroundStyle(Color(.gray))
                            Spacer()
                            Text(place?.properties.contact?.phone ?? "Kunne ikke vise telefonnummer.")
                        }
                        
                        HStack{
                            Text("Åpningstider")
                                .foregroundStyle(Color(.gray))
                            Spacer()
                            Text(place?.properties.openingHours ?? "Kunne ikke vise åpningstider")
                        }
                        
                        HStack{
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
                        }
                        
                        HStack{
                            Text("Kordinater")
                                .foregroundStyle(Color(.gray))
                            Spacer()
                            Text("latitude \(place?.properties.lat ?? 0.0), \nlongitude \(place?.properties.lon ?? 0.0)")
                        }
                        
                        Button{
                            openAppleMaps()
                        } label: {
                            Text("Åpne i Maps")
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                        }
                        .buttonStyleModifier()
                    } // End Section
                } // End Form
                
                
                // Section
                Section("Vurder"){
                    VStack{
                        HStack(spacing: 15){
                            Button {
                                oneStarReview = true
                                twoStarReview = false
                                threeStarReview = false
                                fourStarReview = false
                                fiveStarReview = false
                                starRating = 1
                                
                            } label: {
                                Image(systemName: oneStarReview  ? "star.fill" : "star")
                            }
                            .foregroundStyle(.highlightOrange)
                            
                            Button {
                                oneStarReview = true
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
                                oneStarReview = true
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
                                oneStarReview = true
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
                                oneStarReview = true
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
                            } label: {
                                Image(systemName: "plus")
                            }
                            .buttonStyleModifier()
                        } // End HStack with stars
                        
                    }
                    .padding()
                } // End Section
            }
            // Toolbar
            .toolbar{
                ToolbarItem(placement: .largeTitle) {
                    Text(place?.properties.name ?? "Kunne ikke vise navn")
                        .font(.largeTitle.bold())
                        .foregroundStyle(Color.beaconOrange)
                        .padding()
                }
                
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
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button{
                        dismiss()
                    }label: {
                        Image(systemName:"xmark")
                            .foregroundStyle(Color.white)
                    }
                    .buttonStyleModifier()
                }
            } // End .toolbar
            
        } // End navigationStack
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

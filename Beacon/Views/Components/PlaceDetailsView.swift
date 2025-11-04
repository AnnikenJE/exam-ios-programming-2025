//
//  PlaceDetailsView.swift
//  Beacon
//
// Kandidatnr 97

import SwiftUI

struct PlaceDetailsView: View {
    
    // Enviroments
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    
    // Bindings
    @Binding var place: Feature?
    @Binding var translatedCategory: String
    
    
    // TODO: Kilde
    func openAppleMaps(){
        if let url = URL(string: "https://maps.apple.com/?q=\(place?.properties.addressLine ?? "Kunne ikke vise adresse")") {
            openURL(url)
        }
    }
    
    // --------------------------------------- Body
    var body: some View {
        NavigationStack {
            Form {
                Section("Informasjonn"){
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
                        
                        //TODO: Fjerne utropstegnet, det kan kræsje
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
                }
                Button{
                    openAppleMaps()
                } label: {
                    Text("Åpne i Maps")
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
                .buttonStyleModifier()
            }
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
            }
        }
    }
}

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

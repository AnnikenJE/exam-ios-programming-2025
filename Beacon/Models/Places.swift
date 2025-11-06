//
//  Places.swift
//  Beacon
//
// Kandidatnr 97

// Model for API calls to Geoapify Places

// Places
struct Places: Decodable, Hashable {
    let features: [Feature]    
}

// Feature
struct Feature: Decodable, Hashable {
    let properties: Properties
}

// Properties
struct Properties: Decodable, Hashable {
    let name: String
    let addressLine: String
    let lat: Double
    let lon: Double
    let openingHours: String?
    let website: String?
    let contact: Contact?
    
    enum CodingKeys: String, CodingKey {
        case name
        case addressLine = "address_line2"
        case lat
        case lon
        case openingHours = "opening_hours"
        case website
        case contact
    }
}

// Contact
struct Contact: Decodable, Hashable {
    let phone: String?
    let email: String?
}

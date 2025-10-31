//
//  Places.swift
//  Beacon
//

// Struct for getting information from geoapify places API

struct Places: Decodable, Hashable {
    let features: [Feature]    
}

struct Feature: Decodable, Hashable {
    let properties: Properties
    let openingHours: String?
    let website: String?
    let contact: Contact?
    
    enum CodingKeys: String, CodingKey {
        case properties
        case openingHours = "opening_hours"
        case website
        case contact
    }
}

struct Properties: Decodable, Hashable {
    let name: String
    let addressLine: String
    let lat: Double
    let lon: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case addressLine = "address_line2"
        case lat
        case lon
    }
}
struct Contact: Decodable, Hashable {
    let phone: String?
    let email: String?
}

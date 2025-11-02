//
//  Places.swift
//  Beacon
//
// Kandidatnr 97

struct Places: Decodable, Hashable {
    let features: [Feature]    
}

struct Feature: Decodable, Hashable {
    let properties: Properties
}

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
struct Contact: Decodable, Hashable {
    let phone: String?
    let email: String?
}

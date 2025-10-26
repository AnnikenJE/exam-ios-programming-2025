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

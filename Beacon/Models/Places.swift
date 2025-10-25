//
//  Places.swift
//  Beacon
//
//

struct Places: Decodable, Hashable {
    let features: [Feature]    
}

struct Feature: Decodable, Hashable {
    let properties: Properties
}

struct Properties: Decodable, Hashable {
    let name: String
    let lat: Double
    let lon: Double
}

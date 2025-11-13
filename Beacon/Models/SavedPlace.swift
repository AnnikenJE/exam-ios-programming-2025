//
//  SavedPlace.swift
//  Beacon
//
// Kandidatnr 97

// Model for saving places rating

// Added some properties that are not used, just in case it was needed later.

import SwiftData
import Foundation

@Model
class SavedPlace {
    
    var id: UUID
    var name: String
    var address: String
    var category: String
    var phone: String?
    var email: String?
    var openingHours: String?
    var website: String?
    var lon: Double
    var lat: Double
    
    @Relationship(deleteRule:.cascade, inverse: \Rating.savedPlace)
    var ratings: [Rating]
    
    init(name: String, address: String, ratings: [Rating] = [], category: String, phone: String? = nil, email: String? = nil, openingHours: String? = nil, website: String? = nil, lon: Double, lat: Double) {
        self.id = UUID()
        self.name = name
        self.address = address
        self.ratings = ratings
        self.category = category
        self.phone = phone
        self.email = email
        self.openingHours = openingHours
        self.website = website
        self.lon = lon
        self.lat = lat
    }
}


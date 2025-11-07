//
//  SavedPlace.swift
//  Beacon
//
// Kandidatnr 97

// Model for saving places rating

import SwiftData
import Foundation

@Model
class SavedPlace {
    
    var id: UUID
    var name: String
    var address: String
    
    @Relationship(deleteRule:.cascade, inverse: \Rating.savedPlace)
    var ratings: [Rating]
    
    init(name: String, address: String, ratings: [Rating] = []) {
        self.id = UUID()
        self.name = name
        self.address = address
        self.ratings = ratings
    }
}


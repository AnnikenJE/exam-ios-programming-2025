//
//  Rating.swift
//  Beacon
//
// Kandidatnr 97

// Model for saving places to database

import SwiftData
import Foundation

@Model
class Rating: Identifiable {
    
    var id: UUID
    var savedPlace: SavedPlace
    var stars: Int
    var date: Date
    
    init(savedPlace: SavedPlace, stars: Int) {
        self.id = UUID()
        self.savedPlace = savedPlace
        self.stars = stars
        self.date = Date()
    }
}

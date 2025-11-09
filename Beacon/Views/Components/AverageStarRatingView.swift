//
//  AverageStarRatingView.swift
//  Beacon
//
// Kandidatnr 97

// View for average star rating

import SwiftUI

struct AverageStarRatingView: View {
    
    // States
    @State private var averageRating = 2.5
    
    // --------------------------------------- Body
    var body: some View {
        VStack{
            ZStack{
                Image(systemName: "star")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color.highlightOrange)
                Image(systemName: "star")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color.highlightOrange)
                
            }
        }
    }
}

#Preview {
    AverageStarRatingView()
}


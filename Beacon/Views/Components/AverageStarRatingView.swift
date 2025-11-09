//
//  AverageStarRatingView.swift
//  Beacon
//
// Kandidatnr 97

// View for average star rating

import SwiftUI

struct AverageStarRatingView: View {
    
    // Variables
    var stars: [Int]
    
    // States
    @State private var averageRating = 0.0
    
    func calculateAverage(){
        var sum = 0
        
        for star in stars {
            sum += star
        }
        averageRating = Double(sum) / Double(stars.count)
    }
    
    
    // --------------------------------------- Body
    var body: some View {
        HStack{
            Text(String(format: "%.0f", averageRating))
            ZStack(alignment: .leading){
                
                Image(systemName: "star")
                    .resizable()
                    .foregroundStyle(Color.highlightOrange)
                
                GeometryReader{ geo in
                    Rectangle()
                        .fill(Color.beaconOrange)
                        .frame(width: geo.size.width * CGFloat(averageRating / 5))
                }
                .mask(
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundStyle(Color.highlightOrange))
                
            }
            .frame(width: 30, height: 30)
        }
            .onAppear{
                calculateAverage()
            }
            .onChange(of: stars) { newRating, OldRating in
                calculateAverage()
            }
        }
}


#Preview {
    AverageStarRatingView(stars: [1, 2, 5, 4, 3])
}


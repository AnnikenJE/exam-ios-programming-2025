//
//  RestaurantAnimationView.swift
//  Beacon
//
// Kandidatnr 97

// Animation for places: Restaurant.

import SwiftUI

struct RestaurantAnimationView: View {
    
    // States
    @State private var degrees = 0.0
    
    // Body --------------------------------------- 
    var body: some View {
        Text("🍽️")
            .font(.system(size: 30))
            .rotationEffect(.degrees(degrees))
            .onAppear{
                withAnimation(.easeInOut(duration: 1).delay(0.3)){
                    degrees = 360}
            }
    } // End body
}

// Preview ---------------------------------------
#Preview {
    RestaurantAnimationView()
}

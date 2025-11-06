//
//  ResturantAnimationView.swift
//  Beacon
//
//  Kandidatnummer 97

// Animation for places: Resturant

import SwiftUI

struct ResturantAnimationView: View {
    
    // States
    @State private var degrees = 0.0
    
    // --------------------------------------- Body
    var body: some View {
        Text("🍽️")
            .font(.system(size: 30))
            .rotationEffect(.degrees(degrees))
            .onAppear{
                withAnimation(.easeInOut(duration: 1)){
                    degrees = 360}
            }
    } // End body
}

// --------------------------------------- Preview
#Preview {
    ResturantAnimationView()
}

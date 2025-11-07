//
//  HotelAnimationView.swift
//  Beacon
//
//  Kandidatnummer 97

// Animation for places: Hotel

import SwiftUI

struct HotelAnimationView: View {
    
    // States
    @State private var scale = 0.5
    
    // --------------------------------------- Body
    var body: some View {
        Text("🏨")
            .font(Font.system(size: 30))
            .onAppear{
                withAnimation(.spring(bounce: 0.8).delay(0.3)){
                    scale = 1.0
                }
            }   .scaleEffect(scale)
    } // End Body
}

// --------------------------------------- Preview
#Preview {
    HotelAnimationView()
}

//
//  ResturantAnimationView.swift
//  Beacon
//
//  Kandidatnummer 97

import SwiftUI

struct ResturantAnimationView: View {
    
    // States
    @State private var degrees = 0.0
    
    var body: some View {
        Text("🍽️")
            .font(.system(size: 50))
            .rotationEffect(.degrees(degrees))
            .onAppear{
                withAnimation(.easeInOut(duration: 1)){
                    degrees = 360}
            }
    }
}

#Preview {
    ResturantAnimationView()
}

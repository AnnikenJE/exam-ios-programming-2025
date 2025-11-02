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
        VStack{
            Text("🍽️")
                .font(.system(size: 50))
                .rotationEffect(.degrees(degrees))
                .animation(.easeInOut(duration: 1), value: degrees)
        }
        .onAppear{
            degrees = 360
        }
    }
}

#Preview {
    ResturantAnimationView()
}

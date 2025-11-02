//
//  HotelAnimationView.swift
//  Beacon
//
//  Kandidatnummer 97

import SwiftUI

struct HotelAnimationView: View {
    
    // States
    @State private var scale = 0.5
    
    var body: some View {
        Text("🏨")
            .font(Font.system(size: 50))
            .onAppear{
                withAnimation(.spring(bounce: 0.9)){
                    scale = 1.0
                }
            }   .scaleEffect(scale)
    }
}

#Preview {
    HotelAnimationView()
}

//
//  CafeAnimationView.swift
//  Beacon
//
//  Kandidatnummer 97

// Animation for places: Cafe

import SwiftUI

struct CafeAnimationView: View {
    
    // States
    @State private var opacity1 = 1.0
    @State private var opacity2 = 1.0
    @State private var opacity3 = 1.0
    
    @State private var offsetY1: CGFloat = -35
    @State private var offsetY2: CGFloat = -35
    @State private var offsetY3: CGFloat = -35
    
    // --------------------------------------- Body
    var body: some View {
        VStack {
            Text(" ☕️")
                .font(Font.system(size: 30))
            
            ZStack {
                Text("💨")
                    .rotationEffect(.degrees(270))
                    .font(Font.system(size: 10))
                    .offset(x: 0, y: offsetY1)
                    .opacity(opacity1)
                    .onAppear {
                        withAnimation(.easeOut(duration: 5)
                            .repeatForever()){
                                offsetY1 = -60
                                opacity1 = 0
                            }
                    }
                
                Text("💨")
                    .rotationEffect(.degrees(270))
                    .font(Font.system(size: 7))
                    .offset(x: 5, y: offsetY2)
                    .opacity(opacity2)
                    .onAppear {
                        withAnimation(.easeOut(duration: 5).delay(0.6)
                            .repeatForever()){
                                offsetY2 = -60
                                opacity2 = 0
                            }
                    }
                
                Text("💨")
                    .rotationEffect(.degrees(270))
                    .font(Font.system(size: 5))
                    .offset(x: -5, y: offsetY3)
                    .opacity(opacity3)
                    .onAppear {
                        withAnimation(.easeOut(duration: 5).delay(
                            1.2)
                            .repeatForever()){
                                offsetY3 = -60
                                opacity3 = 0
                            }
                    }
            } // End VStack
        } // End VStack
        .padding(.top, 20)
    } // End body
}

// --------------------------------------- Preview
#Preview {
    CafeAnimationView()
}

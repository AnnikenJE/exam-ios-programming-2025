//
//  CafeAnimationView.swift
//  Beacon
//
//  Kandidatnummer 97

import SwiftUI

struct CafeAnimationView: View {
    
    var body: some View {
        VStack{
            ZStack{
                Text("💨")
                    .rotationEffect(.degrees(270))
                    .font(Font.system(size: 20))
                Text("💨")
                    .rotationEffect(.degrees(270))
                    .font(Font.system(size: 15))
                Text("💨")
                    .rotationEffect(.degrees(270))
                    .font(Font.system(size: 10))
            }
            Text(" ☕️")
                .font(Font.system(size: 50))
        }
    }
}

#Preview {
    CafeAnimationView()
}

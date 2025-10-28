//
//  BeaconPinView.swift
//  Beacon
//

import SwiftUI

// Slettes?

struct BeaconPinView: View {
    public var body: some View {
            ZStack{
                Image(systemName: "arrowtriangle.down.fill")
                    .resizable()
                    .frame(width: 47, height: 33)
                    .offset(y: 23)
                    .foregroundColor(Color(Color.beaconOrange))
                Circle()
                    .fill(Color.beaconOrange)
                    .frame(width: 50)
                Circle()
                    .fill(.white)
                    .frame(width: 30)
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 23, height: 23)
                    .foregroundColor(Color.beaconOrange)
            }
    }
}

#Preview(){
    BeaconPinView()
}

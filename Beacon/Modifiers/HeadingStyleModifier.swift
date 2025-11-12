//
//  HeadingStyleModifier.swift
//  Beacon
//
// Kandidatnr 97

// Default heading styling.

import SwiftUI

struct HeadingStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.beaconOrange)
            .font(.largeTitle.bold())
            .shadow(color: .highlightOrange.opacity(0.5), radius: 5, x: 2, y: 2)
    }
}

extension View {
    func headingStyleModifier() -> some View {
        self.modifier(HeadingStyleModifier())
    }
}

// --------------------------------------- Preview
#Preview {
    VStack {
        Text("Beacon")
            .headingStyleModifier()
            
    }
}

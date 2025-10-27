//
//  ButtonStyleModifier.swift
//  Beacon
//

import SwiftUI

struct ButtonStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .buttonStyle(.glassProminent)
    }    
}

extension View {
    func buttonStyleModifier() -> some View {
        self.modifier(ButtonStyleModifier())
    }
}

#Preview {
    VStack {
        Button {
            // something :)
        } label: {
            Image(systemName: "plus")
        }
        .buttonStyleModifier()
    }
}

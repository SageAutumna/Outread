//
//  HideKeyboardModifier.swift
//  Outread
//
//  Created by AKASH BOGHANI on 25/06/24.
//

import SwiftUI

struct HideKeyboardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                Color.clear
                    .contentShape(Rectangle()) // Make the entire background tappable
                    .onTapGesture {
                        hideKeyboard()
                    }
            )
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func hideKeyboardWhenTappedAround() -> some View {
        self.modifier(HideKeyboardModifier())
    }
}

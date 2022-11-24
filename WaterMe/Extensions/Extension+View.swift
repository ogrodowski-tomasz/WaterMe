//
//  Extension+View.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 24/11/2022.
//

import SwiftUI

// Hiding keyboard extension
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// Hiding placeholder in CustomTextView
extension View {
    @ViewBuilder public func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}

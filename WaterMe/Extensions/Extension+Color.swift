//
//  Extension+Color.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 23/11/2022.
//

import SwiftUI

struct CustomColors {
    let darkGreen = Color("DarkGreen")
    let darkOrange = Color("DarkOrange")
    let light = Color("Light")
    let lightGreen = Color("LightGreen")
    let lightOrange = Color("LightOrange")
}

extension Color {
    static let custom = CustomColors()
    static let textFieldGray = Color.gray.opacity(0.15)
}

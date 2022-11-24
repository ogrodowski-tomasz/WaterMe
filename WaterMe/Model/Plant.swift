//
//  Plant.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 22/11/2022.
//

import Foundation

enum HydrationLevel {
    case watered
    case neutral
    case thirsty
}

struct Plant: Identifiable {
    var id = UUID().uuidString
    var name: String
    var description: String
    var wateringDate: Date
    var imageData: Data
    
//    var isWatered: Bool
//    var hydrationLevel: HydrationLevel {
//        return .watered
//    }
    
//    mutating func toggleIsWatered() {
//        isWatered.toggle()
//    }
    
}

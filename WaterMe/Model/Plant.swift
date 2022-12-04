//
//  Plant.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 22/11/2022.
//

import Foundation

struct Plant: Identifiable {
    var id = UUID().uuidString
    var name: String
    var description: String
    var wateringDate: Date
    var imageData: Data
}

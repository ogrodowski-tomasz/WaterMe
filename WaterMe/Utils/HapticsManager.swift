//
//  HapticsManager.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 25/11/2022.
//

import Foundation
import UIKit

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()

    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}

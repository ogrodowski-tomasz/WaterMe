//
//  UserNotificationsService.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 23/11/2022.
//

import Foundation
import UserNotifications
import SwiftUI

struct UserNotificationsService {
    
    /// withID: we want to have the same id for plant and for notification in order to enable its deletion later.
    func scheduleNotification(withID id: String, titleName name: String, notificationTriggerDate date: Date) {
        let content = UNMutableNotificationContent()
        
        // Problem with localization notification title:
        // Temporary solution taken from stackOverflow (https://stackoverflow.com/questions/26684868/nslocalizedstring-with-variables-swift) -> I'm sure it can be done different.
        let localizedStringNotificationTitle = NSLocalizedString("%@ is thirsty!", comment: "")
        let finalStringNotificationTitle = String(format: localizedStringNotificationTitle, name)
        
        content.title = finalStringNotificationTitle
        content.body = NSLocalizedString("Your plant is thirsty! Give him some water...", comment: "Notification body")
        content.sound = UNNotificationSound.default
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        print("DEBUG: New Notification set at time: [\(dateComponents.description.uppercased())] with id: \(id)")
    }
    
    func removeNotification(notificationId: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationId])
        print("DEBUG: Removed notification with id: \(notificationId)")
    }
    
}

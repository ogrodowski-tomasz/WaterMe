//
//  UserNotificationsService.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 23/11/2022.
//

import Foundation
import UserNotifications

struct UserNotificationsService {
    
    /// withID: we want to have the same id for plant and for notification in order to enable its deletion later.
    func scheduleNotification(withID id: String, titleName name: String, notificationTriggerDate date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "\(name) is thirsty!"
        content.body = "Your plant is thirsty! Give him some water..."
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

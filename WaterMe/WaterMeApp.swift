//
//  WaterMeApp.swift
//  WaterMe
//
//  Created by Tomasz Ogrodowski on 22/11/2022.
//

import SwiftUI
import UserNotifications

@main
struct WaterMeApp: App {
    
    
    init() {
        requestNotificationPermission()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                    .preferredColorScheme(.dark)
            }
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("DEBUG: Permission for notifications granted")
            } else if let error {
                print("DEBUG: Error getting authorization for notifications: \(error.localizedDescription)")
            }
        }
    }
}


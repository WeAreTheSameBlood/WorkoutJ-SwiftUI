//
//  NotificationManager.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 24.08.2023.
//

import SwiftUI
import NotificationCenter

class NotificationManagerService {
    public static let shared = NotificationManagerService()
    private let center = UNUserNotificationCenter.current()
    
    private init() {}
    
    public func requestAuthorization() {
        center.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if granted {
                        print("Notification permission granted")
                    } else {
                        print("Notification permission not received")
                    }
                }
            case .denied:
                print("Notifications were previously denied by the user.")
            case .authorized, .provisional:
                print("Notifications are allowed.")
            default:
                break
            }
        }
    }
    
    public func scheduleNotification(time: Int, title: String, body: String) {
        // in plan
    }
    
}


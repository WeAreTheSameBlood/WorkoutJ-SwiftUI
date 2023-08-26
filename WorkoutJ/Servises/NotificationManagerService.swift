//
//  NotificationManager.swift
//  WorkoutJ
//
//  Created by Andrii Hlybchenko on 24.08.2023.
//

import SwiftUI
import NotificationCenter

class NotificationManagerService {
    
    private init() {}
    public static let shared = NotificationManagerService()
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    public func requestAuthorization() {
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
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


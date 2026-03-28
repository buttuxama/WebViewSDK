//
//  NotificationManager.swift
//  WebViewSDK
//
//  Created by Usama on 11/22/22.
//

import UIKit
import UserNotifications

class NotificationManager: NSObject {
    
    static let shared = NotificationManager()
    
    private override init() {
    }
    
    func sendNotification(title: String, body: String, badge: Int?, delayInterval: Int?){
        
        UNUserNotificationCenter.current().delegate = self
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        notificationContent.sound = .default
        
        var delayTimeTrigger: UNTimeIntervalNotificationTrigger?
        if let delayInterval {
            delayTimeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(delayInterval), repeats: false)
        }
        
        if let badge {
            var currentBadgeCount = UIApplication.shared.applicationIconBadgeNumber
            currentBadgeCount += badge
            notificationContent.badge = NSNumber(integerLiteral: currentBadgeCount)
        }
        
        let request = UNNotificationRequest(identifier: "Notifications", content: notificationContent, trigger: delayTimeTrigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("notification is about to present.")
        
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let identifier = response.actionIdentifier
        
        switch identifier {
        case UNNotificationDismissActionIdentifier:
            print("User dismissed the notification.")
            completionHandler()
        case UNNotificationDefaultActionIdentifier:
            print("User opened the app from notification.")
            completionHandler()
        default:
            print("Default case was called.")
            completionHandler()
        }
    }
}

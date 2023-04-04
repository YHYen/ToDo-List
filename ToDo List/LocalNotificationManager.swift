//
//  LocalNotificationManager.swift
//  ToDo List
//
//  Created by 顏逸修 on 2023/4/3.
//

import UIKit
import UserNotifications

struct LocalNotificationManager {
    static func authorizeLocalNotifications(viewController: UIViewController) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error)
            in
            
            guard error == nil else {
                print("😡 ERROR: \(error!.localizedDescription)")
                return
            }
            if granted {
                print("✓ Notification Authorized Granted!")
            } else {
                print("🚫 The user has denied notifications!")
                
                // put the alert in here telling the user what to do. (Needs to run in the main thread)
                DispatchQueue.main.sync {
                    viewController.oneButtonAlert(title: "User has not allow notification", message: "To receive alerts to reminders, open the Settings app, select To Do List > Notifications > Allow Notifications.")
                }
            }
        }
    }
    
    
    static func isAuthorized(completed: @escaping (Bool) -> () ) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error)
            in
            guard error == nil else {
                print("😡 ERROR: \(error!.localizedDescription)")
                completed(false)
                return
            }
            if granted {
                print("✓ Notification Authorized Granted!")
                completed(true)
            } else {
                print("🚫 The user has denied notifications!")
                completed(false)
            }
        }
    }
    
    
    static func setCalendarNotification(title: String, subtitle: String, body: String, badgeNumber: NSNumber?, sound: UNNotificationSound?, date: Date) -> String {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.badge = badgeNumber
        content.sound =  sound
        
        // create trigger
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateComponents.second = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // create request
        let notificationID = UUID().uuidString
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("😡 ERROR: \(error.localizedDescription) Yikes, adding notification request went wrong!")
            }else {
                print("Notification scheduled \(notificationID), title: \(content.title)")
            }
        }
        
        return notificationID
    }
}

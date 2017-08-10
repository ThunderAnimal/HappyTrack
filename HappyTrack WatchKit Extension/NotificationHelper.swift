//
//  NotificationHelper.swift
//  HappyTrack
//
//  Created by Martin Weber on 09.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import WatchKit
import UserNotifications

class NotificationHelper: NSObject {
    
    public func initSetUpNotifications(){
        let generalCategory = UNNotificationCategory(identifier: Constants.NotificationCategory.general.indentifier(),actions: [],intentIdentifiers: [],options: .customDismissAction)
        
        /*let trackAction = UNNotificationAction(identifier: Constants.NotificationAction.track_action.indentifier(), title: "Track Happiness", options: UNNotificationActionOptions(rawValue: 0))*/
        let trackHappiness = UNNotificationCategory(identifier: Constants.NotificationCategory.happytrack_needed.indentifier(), actions: [], intentIdentifiers: [], options: .customDismissAction)
        
        let center = UNUserNotificationCenter.current()
        center.setNotificationCategories([generalCategory, trackHappiness])
        
    }
    
    public func registerLocalNotification(startHour:Int, endHour:Int, interval:Int){
        let dateNow = Date()
        let dateNowString = DateFormatter()
        dateNowString.dateFormat = "y-MM-dd H:m:ss.SSSS"
        
        var hour = startHour
        
        while (hour < endHour) {
            let cal = Calendar(identifier: Calendar.Identifier.gregorian)
            let date = (cal as NSCalendar).date(bySettingHour: hour, minute: 0, second: 0, of: Date(), options: NSCalendar.Options())
            let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second], from: date!)
            
            let content = UNMutableNotificationContent()
            content.title = "Hey what's Up?"
            content.body = "Time to Track Happiness. Your are amazing!"
            content.categoryIdentifier = Constants.NotificationCategory.happytrack_needed.indentifier()

            content.sound = UNNotificationSound.default()
            
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
            let request = UNNotificationRequest(identifier: "Hour-" + String(hour) + "_" + dateNowString.string(from: dateNow), content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
                if((error) != nil){
                    print("Problems to register Notification")
                }
            })
            
            hour += interval
        }
        
    }
    
    public func unscheduleLocalNotications(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    public func pushLocalNotification(identifier: String, title:String, body:String){
        
        let dateNow = Date()
        let dateNowString = DateFormatter()
        dateNowString.dateFormat = "y-MM-dd H:m:ss.SSSS"
        
        let DateIdentifier = identifier + "_" + dateNowString.string(from: dateNow)
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.categoryIdentifier = Constants.NotificationCategory.general.indentifier()
        content.sound = UNNotificationSound.default()
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: DateIdentifier, content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if((error) != nil){
                print("Problems to push Notification")
            }
        }
    }

}

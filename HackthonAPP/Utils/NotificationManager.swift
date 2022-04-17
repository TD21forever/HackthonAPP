//
//  NotificationManager.swift
//  HackthonAPP
//
//  Created by T D on 2022/4/16.
//

import Foundation
import UserNotifications
import SwiftUI

class NotificationManager{
    static let instance = NotificationManager()
    
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    @Published private(set) var notifications:[UNNotificationRequest] = []
    func reloadAuthorizationStatus(){
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    func requestAuthorization(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, _ in
            DispatchQueue.main.async {

                self.authorizationStatus = isGranted ? .authorized : .denied
            }
        }
    }
    func reloadLocalNotifications(){
        UNUserNotificationCenter.current().getPendingNotificationRequests { notificationsData in
//            DispatchQueue.main.async {
//                self.notifications = notificationsData
//
//            }
            self.notifications = notificationsData
        }
    }
    
    func createLocalNotification(title:String, hour: Int, minute: Int, repeate:Bool, completion: @escaping (Error?)->Void){
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeate)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
    }
    
    func createLocalNotificationForSpecificDay(title:String, day:Int, hour: Int, minute: Int,  completion: @escaping (Error?)->Void){
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.day = day
    
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
        
        
    }
    
}

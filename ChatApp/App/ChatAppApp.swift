//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Benji Loya on 08.08.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseMessaging
import SwiftfulRouting
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
    application.registerForRemoteNotifications()
    FirebaseApp.configure()
    Messaging.messaging().delegate = self
      
    UNUserNotificationCenter.current().delegate = self
    return true
  }
}

// Notifications
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.sound, .badge, .banner, .list]
    }
}

// Firebase messaging - notifications
extension AppDelegate: MessagingDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        #if DEBUG
        print("FCM Token: \(fcmToken)")
        #endif
    }
    
}

@main
struct ChatAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                ContentView()
            }
        }
    }
}

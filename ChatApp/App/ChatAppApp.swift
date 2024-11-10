//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Benji Loya on 08.08.2023.
//

import SwiftUI
import FirebaseCore
import SwiftfulRouting

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
    FirebaseApp.configure()
      
    return true
  }
}

@main
struct ChatAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    //MARK: For In App Notifications
    @State private var overlayWindow: PassThroughWindow?
    
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                ContentView()
                //MARK: For In App Notifications
                    .onAppear(perform: {
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            let overlayWindow = PassThroughWindow(windowScene: windowScene)
                            overlayWindow.backgroundColor = .clear
                            overlayWindow.tag = 0320
                            let controller = StatusBarBasedController()
                            controller.view.backgroundColor = .clear
                            overlayWindow.rootViewController = controller
                            overlayWindow.isHidden = false
                            overlayWindow.isUserInteractionEnabled = true
                            self.overlayWindow = overlayWindow
                          //  print("Overlay Window Created")
                            
                        }
                    })
            }
        }
    }
}


//MARK: For In App Notifications
 class StatusBarBasedController: UIViewController {
    var statusBarStyle: UIStatusBarStyle = .default
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
}

fileprivate class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else { return nil }
        return rootViewController?.view == view ? nil : view
    }
}

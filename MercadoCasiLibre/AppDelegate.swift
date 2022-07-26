//
//  AppDelegate.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 20/07/2022.
//
import UIKit
import Toaster
import Network

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let monitor = NWPathMonitor()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        let barAppearance = UINavigationBar.appearance()

        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .yellowColor
            barAppearance.standardAppearance = appearance
            barAppearance.scrollEdgeAppearance = appearance
        } else {
            barAppearance.backgroundColor = .yellowColor
        }
        
        ToastView.appearance().backgroundColor = .systemRed
        ToastView.appearance().layer.borderWidth = 4
        ToastView.appearance().layer.cornerRadius = 2

        ToastView.appearance().textColor = .lightGrayColor
        ToastView.appearance().font = .boldSystemFont(ofSize: 22)
        
        monitor.start(queue: .global()) // Deliver updates on the background queue
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                Toast(text: CustomError.noNetworkConnection.errorDescription).show()
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

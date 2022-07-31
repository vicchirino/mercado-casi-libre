//
//  TabBarController.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 20/07/2022.
//

import UIKit
import SnapKit
import SwiftIcons
import Toaster

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupViews() {
        tabBar.backgroundColor = .white
        UITabBar.appearance().tintColor = .blueColor
    }
    
    private func setupTabItems() {
        let homeViewController = HomeViewController()
        let homeItem = UITabBarItem(title: "Inicio", image: UIImage.init(icon: .ionicons(.iosHomeOutline), size: CGSize(width: 32, height: 32)), tag: 0)
        homeViewController.tabBarItem = homeItem
        
        let favouriteController = FavouritesViewController()
        let favouriteItem = UITabBarItem(title: "Favoritos", image: UIImage.init(icon: .ionicons(.iosHeartOutline), size: CGSize(width: 32, height: 32)), tag: 1)
        favouriteController.tabBarItem = favouriteItem
        
        let myShoppingController = MyShoppingViewController()
        let myShoppingItem = UITabBarItem(title: "Mis Compras", image: UIImage.init(icon: .ionicons(.bag), size: CGSize(width: 32, height: 32)), tag: 2)
        myShoppingItem.isEnabled = false
        myShoppingController.tabBarItem = myShoppingItem
        
        let notificationsController = NotificationsViewController()
        let notificationItem = UITabBarItem(title: "Notificaciones", image: UIImage.init(icon: .ionicons(.iosBellOutline), size: CGSize(width: 32, height: 32)), tag: 3)
        notificationsController.tabBarItem = notificationItem
        
        let settingsController = SettingsViewController()
        let settingsItem = UITabBarItem(title: "Mas", image: UIImage.init(icon: .ionicons(.iosSettings), size: CGSize(width: 32, height: 32)), tag: 4)
        settingsItem.isEnabled = false
        settingsController.tabBarItem = settingsItem
        
        viewControllers = [homeViewController, favouriteController, myShoppingController, notificationsController, settingsController]
    }
    
}

extension TabBarController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected \(item.title!)")
        switch item.tag {
        case 2, 4:
            Toast(text: CustomError.featureUnavailable.errorDescription).show()
            selectedIndex = 1
        default:
            return
        }
    }
}


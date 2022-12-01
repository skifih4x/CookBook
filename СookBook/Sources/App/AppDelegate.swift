//
//  AppDelegate.swift
//  СookBook
//
//  Created by Артем Орлов on 28.11.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = CookTabBarController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}

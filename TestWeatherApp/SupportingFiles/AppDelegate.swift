//
//  AppDelegate.swift
//  TestWeatherApp
//
//  Created by Khushvaktov Temur on 12.06.2021.
//

import UIKit
import SDWebImageSVGCoder

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()

        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)

        let navigationController = UINavigationController(rootViewController: ViewController())
        navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.03214389458, green: 0.1046723947, blue: 0.1467950046, alpha: 1)
        navigationController.navigationBar.tintColor = #colorLiteral(red: 0.7780510783, green: 0.7922836542, blue: 0.792152822, alpha: 1)
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:  #colorLiteral(red: 0.7780510783, green: 0.7922836542, blue: 0.792152822, alpha: 1)]

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

}


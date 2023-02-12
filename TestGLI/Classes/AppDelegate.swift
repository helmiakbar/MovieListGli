//
//  AppDelegate.swift
//  TestGLI
//
//  Created by SehatQ on 10/02/23.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        makeViewAndSetupAppearance()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = NSLocalizedString("Selesai", comment: "")
        return true
    }
}

extension AppDelegate {
    class func getRootViewController() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    
    func makeViewAndSetupAppearance() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeVC = HomeViewController(nibName:"HomeViewController",bundle:nil)
        let navVC = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}

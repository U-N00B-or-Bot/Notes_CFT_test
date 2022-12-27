//U-N00B-or-Bot

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navVC = UINavigationController()
        let mainVC = MainViewController()
        navVC.viewControllers = [mainVC]
        self.window!.rootViewController = navVC
        self.window?.makeKeyAndVisible()
        
        return true
    }
}


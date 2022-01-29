//
//  AppDelegate.swift
//  MyWeatherApp
//
//  Created by Augusto Monteiro on 09/01/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = makeRootViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
    private func makeRootViewController() -> UIViewController {
        let view = UINavigationController(
            rootViewController: UIComposer.weatherViewComposedWith(
                weatherLoader: RemoteWeatherLoader(client: URLSessionClient())))
        return view
    }
    
}

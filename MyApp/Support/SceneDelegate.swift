//
//  SceneDelegate.swift
//  MyApp
//
//  Created by Halkbank on 20.08.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        // Set the TabBarViewController as the root view controller
        window.rootViewController = TabBarViewController()
        self.window = window
        window.makeKeyAndVisible()
    }
}


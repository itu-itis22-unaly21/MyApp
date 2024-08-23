//
//  TabBarViewController.swift
//  MyApp
//
//  Created by Halkbank on 20.08.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gameViewController = GameViewController()
        let gameNavController = UINavigationController(rootViewController: gameViewController)
        gameNavController.tabBarItem = UITabBarItem(title: "Games", image: UIImage(systemName: "gamecontroller"), tag: 0)
        
        let favouriteViewController = FavouriteViewController()
        let favouriteNavController = UINavigationController(rootViewController: favouriteViewController)
        favouriteNavController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "star"), tag: 1)
        
        self.viewControllers = [gameNavController, favouriteNavController]
        self.tabBar.backgroundColor = .white
        self.tabBar.barTintColor = .white
        self.tabBar.isTranslucent = false
        
        let border = UIView(frame: CGRect(x: 0, y: 0, width: self.tabBar.frame.width, height: 0.7))
        border.backgroundColor = UIColor.lightGray
        self.tabBar.addSubview(border)
    }
}

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
        
        // Add the navigation controllers to the tab bar
        self.viewControllers = [gameNavController, favouriteNavController]
    }
}

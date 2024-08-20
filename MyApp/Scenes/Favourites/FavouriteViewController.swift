//
//  FavouriteGameController.swift
//  MyApp
//
//  Created by Halkbank on 20.08.2024.
//

import UIKit

class FavouriteViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//
//  GameViewController.swift
//  MyApp
//
//  Created by Halkbank on 20.08.2024.
//

import UIKit

final class GameViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureSearchBar()
    }
    
    private func configureSearchBar() {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search for the games"
        searchBar.delegate = self
        searchBar.layer.borderWidth = 0
        searchBar.searchBarStyle = .minimal
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7),
            searchBar.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}


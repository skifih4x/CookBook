//
//  CookTabBarController.swift
//  СookBook
//
//  Created by Артем Галай on 28.11.22.
//

import UIKit

final class CookTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTabBarViewControllers()
    }

    private func setupTabBar() {
        tabBar.backgroundColor = .systemGray6
        tabBar.tintColor = .systemGreen
    }

    private func setupTabBarViewControllers() {

        let popularRecipes = UINavigationController(rootViewController: PopularRecipesViewController())
        let savedRecipes = UINavigationController(rootViewController: SavedRecipesViewController())

        setViewControllers([popularRecipes, savedRecipes], animated: true)

        popularRecipes.title = "Popular recipes"
        savedRecipes.title = "Saved recipes"

        popularRecipes.tabBarItem.image = UIImage(systemName: "house")
        savedRecipes.tabBarItem.image = UIImage(systemName: "square.and.arrow.down")

        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: "Arial", size: 14) as Any],
                                                         for: .normal)
    }
}

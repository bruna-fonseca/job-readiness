//
//  File.swift
//  job-readiness
//
//  Created by Bruna Marques De Oliveira Fonseca on 18/09/22.
//

import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()

    }
    
    private func setupTabBarController() {
        let searchScreen = UINavigationController(rootViewController: SearchProductsViewController())
        let favoriteScreen = UINavigationController(rootViewController: FavoriteProductsViewController())
        
        self.setViewControllers([searchScreen, favoriteScreen], animated: false)
        self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = true
        
        guard let items = tabBar.items else { return }
        items[0].title = "Home"
        items[0].image = UIImage(systemName: "house")
        items[1].title = "Favoritos"
        items[1].image = UIImage(systemName: "heart")
        
    }
    
}

//
//  TabBarController.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/21.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .white
        self.configureTabs()
    }
    
    private func configureTabs() {
        let home = HomeViewController()
        home.tabBarItem = UITabBarItem(
            title: .none,
            image: .home?.withRenderingMode(.alwaysOriginal),
            selectedImage: .homeSelected?.withRenderingMode(.alwaysOriginal)
        )
        
        let search = SearchViewController()
        search.tabBarItem = UITabBarItem(
            title: .none,
            image: .search?.withRenderingMode(.alwaysOriginal),
            selectedImage: .searchSelected?.withRenderingMode(.alwaysOriginal)
        )
        
        let reels = ReelsViewController()
        reels.tabBarItem = UITabBarItem(
            title: .none,
            image: .reels?.withRenderingMode(.alwaysOriginal),
            selectedImage: .reelsSelected?.withRenderingMode(.alwaysOriginal)
        )
        
        let shop = ShopViewController()
        shop.tabBarItem = UITabBarItem(
            title: .none,
            image: .shop?.withRenderingMode(.alwaysOriginal),
            selectedImage: .shopSelected?.withRenderingMode(.alwaysOriginal)
        )
        
        let profile = ProfileViewController()
        profile.tabBarItem = UITabBarItem(
            title: .none,
            image: .profile?.withRenderingMode(.alwaysOriginal),
            selectedImage: .profileSelected?.withRenderingMode(.alwaysOriginal)
        )
        
        self.viewControllers = [home, search, reels, shop, profile]
    }
    
}

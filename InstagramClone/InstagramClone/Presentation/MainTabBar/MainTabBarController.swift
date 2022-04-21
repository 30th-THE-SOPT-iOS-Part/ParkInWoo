//
//  MainTabBar.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/21.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .white
        self.configureTabs()
    }
    
    private func configureTabs() {
        let home = UIViewController()
        home.view.backgroundColor = .red
        home.tabBarItem = UITabBarItem(
            title: .none,
            image: .home?.withRenderingMode(.alwaysOriginal),
            selectedImage: .homeSelected?.withRenderingMode(.alwaysOriginal)
        )
        
        let search = UIViewController()
        search.view.backgroundColor = .yellow
        search.tabBarItem = UITabBarItem(
            title: .none,
            image: .search?.withRenderingMode(.alwaysOriginal),
            selectedImage: .searchSelected?.withRenderingMode(.alwaysOriginal)
        )
        
        let reels = UIViewController()
        reels.view.backgroundColor = .green
        reels.tabBarItem = UITabBarItem(
            title: .none,
            image: .reels?.withRenderingMode(.alwaysOriginal),
            selectedImage: .reelsSelected?.withRenderingMode(.alwaysOriginal)
        )
        
        let shop = UIViewController()
        shop.view.backgroundColor = .blue
        shop.tabBarItem = UITabBarItem(
            title: .none,
            image: .shop?.withRenderingMode(.alwaysOriginal),
            selectedImage: .shopSelected?.withRenderingMode(.alwaysOriginal)
        )
        
        let profile = UIViewController()
        profile.view.backgroundColor = .purple
        profile.tabBarItem = UITabBarItem(
            title: .none,
            image: .profile?.withRenderingMode(.alwaysOriginal),
            selectedImage: .profileSelected?.withRenderingMode(.alwaysOriginal)
        )
        
        self.viewControllers = [home, search, reels, shop, profile]
    }
    
}

//
//  TabBarController.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/21.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private lazy var homeViewController: HomeViewController = {
        let home = HomeViewController()
        home.tabBarItem = UITabBarItem(
            title: .none,
            image: Asset.TabBar.home?.withRenderingMode(.alwaysTemplate),
            selectedImage: Asset.TabBar.homeSelected?.withRenderingMode(.alwaysTemplate)
        )
        return home
    }()
    
    private lazy var searchViewController: SearchViewController = {
        let search = SearchViewController()
        search.tabBarItem = UITabBarItem(
            title: .none,
            image: Asset.TabBar.search?.withRenderingMode(.alwaysTemplate),
            selectedImage: Asset.TabBar.searchSelected?.withRenderingMode(.alwaysTemplate)
        )
        return search
    }()
    
    private lazy var reelsViewController: ReelsViewController = {
        let reels = ReelsViewController()
        reels.tabBarItem = UITabBarItem(
            title: .none,
            image: Asset.TabBar.reels?.withRenderingMode(.alwaysTemplate),
            selectedImage: Asset.TabBar.reelsSelected?.withRenderingMode(.alwaysTemplate)
        )
        return reels
    }()
    
    private lazy var shopViewController: ShopViewController = {
        let shop = ShopViewController()
        shop.tabBarItem = UITabBarItem(
            title: .none,
            image: Asset.TabBar.shop?.withRenderingMode(.alwaysTemplate),
            selectedImage: Asset.TabBar.shopSelected?.withRenderingMode(.alwaysTemplate)
        )
        return shop
    }()
    
    private lazy var profileViewController: ProfileViewController = {
        let profile = ProfileViewController()
        profile.tabBarItem = UITabBarItem(
            title: .none,
            image: Asset.TabBar.profile?.withRenderingMode(.alwaysOriginal),
            selectedImage: Asset.TabBar.profileSelected?.withRenderingMode(.alwaysOriginal)
        )
        return profile
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .black
        tabBar.backgroundColor = .white
        viewControllers = [homeViewController, searchViewController, reelsViewController, shopViewController, profileViewController]
    }
    
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is ReelsViewController {
            tabBar.tintColor = .white
            tabBar.unselectedItemTintColor = .white
            tabBar.backgroundColor = .black
        } else {
            tabBar.tintColor = .black
            tabBar.unselectedItemTintColor = .black
            tabBar.backgroundColor = .white
        }
    }
}

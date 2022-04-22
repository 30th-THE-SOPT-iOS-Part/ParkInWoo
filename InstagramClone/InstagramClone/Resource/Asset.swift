//
//  Asset.swift
//  InstagramClone
//
//  Created by Inwoo Park on 2022/04/22.
//

import UIKit

enum Asset {
    enum Common {
        static var logo: UIImage? { return UIImage(named: "icn_logo") }
    }
    
    enum NavBar {
        static var back: UIImage? { return UIImage(named: "icn_back") }
    }
    
    enum Login {
        static var hiddenEye: UIImage? { return UIImage(named: "icn_password_hidden") }
        static var shownEye: UIImage? { return UIImage(named: "icn_password_shown") }
    }
    
    enum TabBar {
        static var home: UIImage? { return UIImage(named: "icn_home") }
        static var homeSelected: UIImage? { return UIImage(named: "icn_home_selected") }
        static var search: UIImage? { return UIImage(named: "icn_search") }
        static var searchSelected: UIImage? { return UIImage(named: "icn_search_selected") }
        static var reels: UIImage? { return UIImage(named: "icn_reels") }
        static var reelsSelected: UIImage? { return UIImage(named: "icn_reels_selected") }
        static var shop: UIImage? { return UIImage(named: "icn_shop") }
        static var shopSelected: UIImage? { return UIImage(named: "icn_shop_selected") }
        static var profile: UIImage? { return UIImage(named: "icn_profile") }
        static var profileSelected: UIImage? { return UIImage(named: "icn_profile_selected") }
    }
}

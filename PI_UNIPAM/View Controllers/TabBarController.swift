//
//  TabBarController.swift
//  PI_UNIPAM
//
//  Created by Danilo Constancio on 24/04/22.
//

import UIKit
import SFSymbol

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTabBar()
        updateViewControllers()
    }
    
    func updateViewControllers() {
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Início", image: UIImage(symbol: SFSymbol.house), selectedImage: UIImage(symbol: SFSymbol.house))
        
        let myArticlesVC = MyArticlesViewController()
        myArticlesVC.tabBarItem = UITabBarItem(title: "Meus artigos", image: UIImage(symbol: SFSymbol.book), selectedImage: UIImage(symbol: SFSymbol.book))
        
        let myProfileVC = MyProfileViewController()
        myProfileVC.tabBarItem = UITabBarItem(title: "Meu Perfil", image: UIImage(symbol: SFSymbol.person), selectedImage: UIImage(symbol: SFSymbol.person))
        
        if Reference.currentUser != nil {
            viewControllers = [NavigationController(rootViewController: homeVC),
                               NavigationController(rootViewController: myArticlesVC),
                               NavigationController(rootViewController: myProfileVC)]
        } else {
            viewControllers = [NavigationController(rootViewController: homeVC)]
        }
        
        updateTabBar()
    }
    
    private func updateTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Asset.backgroundColor.color
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        tabBar.isTranslucent = false
        tabBar.tintColor = Asset.blue.color
        tabBar.unselectedItemTintColor = Asset.darkFiveHundred.color
    }
}

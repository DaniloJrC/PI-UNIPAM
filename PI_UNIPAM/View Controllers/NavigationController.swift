//
//  NavigationController.swift
//  PI_UNIPAM
//
//  Created by Danilo Constancio on 24/04/22.
//

import UIKit

final class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavigationBarStyle()
    }
    
    private func updateNavigationBarStyle() {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: Asset.darkNineHundred.color,
                                                          .font: UIFont.systemFont(ofSize: 16, weight: .bold)]
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Asset.backgroundColor.color
        appearance.titleTextAttributes = attributes
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        navigationBar.barStyle = .default
        navigationBar.backgroundColor = Asset.backgroundColor.color
        navigationBar.barTintColor = Asset.darkNineHundred.color
        navigationBar.tintColor = Asset.darkNineHundred.color
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = attributes
    }
}

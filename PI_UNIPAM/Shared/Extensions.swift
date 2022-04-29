//
//  Extensions.swift
//  PI_UNIPAM
//
//  Created by Danilo Constancio on 24/04/22.
//

import UIKit

extension UIViewController {
    func setupNavigationBar() {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor : Asset.darkNineHundred.color,
                                                         .font            : UIFont.systemFont(ofSize: 16, weight: .bold)]
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Asset.backgroundColor.color
        appearance.titleTextAttributes = attributes
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.backgroundColor = Asset.backgroundColor.color
        navigationController?.navigationBar.barTintColor = Asset.darkNineHundred.color
        navigationController?.navigationBar.tintColor = Asset.darkNineHundred.color
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationItem.hidesBackButton = true
    }
    
    @objc private func backPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension UITableViewCell {
    static var identifier: String { String(describing: self) }
}

//
//  ScrollableViewController.swift
//  PI_UNIPAM
//
//  Created by Danilo Constancio on 26/04/22.
//

import UIKit
import TPKeyboardAvoiding

class ScrollableViewController: UIViewController {
    
    private(set) lazy var scrollView: TPKeyboardAvoidingScrollView = {
        let scrollView = TPKeyboardAvoidingScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private(set) lazy var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = Asset.backgroundColor.color
        scrollView.backgroundColor = Asset.backgroundColor.color
        contentView.backgroundColor = Asset.backgroundColor.color
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.centerX.width.equalTo(view)
            make.height.greaterThanOrEqualTo(view)
        }
    }
}

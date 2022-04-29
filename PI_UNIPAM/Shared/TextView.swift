//
//  TextView.swift
//  PI_UNIPAM
//
//  Created by Danilo Constancio on 24/04/22.
//

import UIKit

final class TextView: UIView {
    private(set) lazy var textField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.returnKeyType = .continue
        textField.clearButtonMode = .never
        textField.textAlignment = .left
        textField.tintColor = Asset.darkNineHundred.color
        textField.textColor = Asset.darkNineHundred.color
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.backgroundColor = Asset.backgroundColor.color
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = Asset.darkThreeHundred.color.cgColor
        layer.cornerRadius = 8
        
        addSubview(textField)
    }
    
    private func setupConstraints() {
        
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
}

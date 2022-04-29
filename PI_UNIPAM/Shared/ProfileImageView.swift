//
//  ProfileImageView.swift
//  PI_UNIPAM
//
//  Created by Danilo Constancio on 26/04/22.
//

import UIKit
import SFSymbol

final class ProfileImageView: UIView {
    
    var image: UIImage? {
        get { profileImageView.image }
        set { profileImageView.image = newValue }
    }
    
    private lazy var contentView = UIView()
    
    private(set) lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(symbol: SFSymbol.person)?.withTintColor(Asset.darkThreeHundred.color, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    private(set) lazy var editImageButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.setImage(UIImage(symbol: SFSymbol.camera)?.withTintColor(Asset.darkThreeHundred.color, renderingMode: .alwaysOriginal), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        button.backgroundColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = Asset.green.color.cgColor
        contentView.layer.cornerRadius = frame.width / 2
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.masksToBounds = true
        bringSubviewToFront(editImageButton)
    }
    
    private func setupViews() {
        
        addSubview(contentView)
        contentView.addSubview(profileImageView)
        addSubview(editImageButton)
    }
    
    private func setupConstraints() {
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(6)
        }
        
        editImageButton.snp.makeConstraints { make in
            make.center.equalToSuperview().offset(39)
            make.size.equalTo(32)
        }
    }
}

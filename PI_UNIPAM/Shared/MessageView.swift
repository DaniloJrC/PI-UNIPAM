//
//  MessageView.swift
//  PI_UNIPAM
//
//  Created by Danilo Constancio on 25/04/22.
//

import UIKit

enum MessageType {
    case success
    case warning
    case error
}

final class MessageView: UIView {
    private let messageType: MessageType
    private let title: String
    private let subtitle: String
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        
        switch messageType {
        case .success:
            view.backgroundColor = Asset.green.color
            
        case .warning:
            view.backgroundColor = Asset.red.color
            
        case .error:
            view.backgroundColor = Asset.red.color
        }
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        switch messageType {
        case .success:
            imageView.image = UIImage(named: "success-icon")
            
        case .warning:
            imageView.image = UIImage(named: "warning-icon")
            
        case .error:
            imageView.image = UIImage(named: "error-icon")
        }
        
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .bold)

        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = subtitle
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    init(messageType: MessageType, title: String, subtitle: String) {
        self.messageType = messageType
        self.title = title
        self.subtitle = subtitle
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
    }
    
    private func setupConstraints() {
        
        contentView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(20)
            make.top.equalTo(snp.topMargin).inset(16)
            make.height.greaterThanOrEqualTo(72)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(40)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.greaterThanOrEqualToSuperview().inset(16)
            make.leading.equalTo(imageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}

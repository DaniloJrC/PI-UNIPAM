//
//  ArticleCell.swift
//  PIUNIPAM
//
//  Created by Danilo Constancio on 24/04/22.
//


import UIKit
import SnapKit

final class ArticleCell: UITableViewCell {
    
    var article: Article? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var roundedView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 16
        view.layer.borderColor = Asset.darkThreeHundred.color.cgColor
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = Asset.darkNineHundred.color
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = Asset.darkSevenHundred.color
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Asset.darkFiveHundred.color
        return label
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Asset.darkSevenHundred.color
        return label
    }()
    
    private lazy var readButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.contentHorizontalAlignment = .right
        button.setTitle("Continuar leitura", for: .normal)
        button.setTitleColor(Asset.green.color, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = Asset.backgroundColor.color
    }
    
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = Asset.backgroundColor.color
        contentView.addSubview(roundedView)
        roundedView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(bottomStackView)
        bottomStackView.addArrangedSubview(dateLabel)
        bottomStackView.addArrangedSubview(readButton)
    }
    
    private func setupConstraints() {
        
        roundedView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    private func updateUI() {
        if let article = article {
            titleLabel.text = article.title
            descriptionLabel.text = article.text
            dateLabel.text = article.createdAt.formatted()
            authorLabel.text = article.author.name
        }
    }
}

extension Date {
    func formatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
}

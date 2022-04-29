//
//  CreateArticleViewController.swift
//  PI_UNIPAM
//
//  Created by Danilo Constancio on 27/04/22.
//

import UIKit

final class CreateArticleViewController: ScrollableViewController {
    
    private let article: Article?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var titleTextView: TextView = {
        let textView = TextView()
        textView.textField.text = article?.title
        textView.textField.textContentType = .emailAddress
        textView.textField.keyboardType = .emailAddress
        textView.textField.placeholder = "Título"
        return textView
    }()
    
    private lazy var subtitleView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.layer.borderColor = Asset.darkThreeHundred.color.cgColor
        return view
    }()
    
    private lazy var subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.text = article == nil ? "Escreva o subtítulo aqui" : article?.subtitle
        textView.textAlignment = .left
        textView.font = .systemFont(ofSize: 16, weight: .bold)
        textView.textColor = Asset.darkNineHundred.color
        return textView
    }()
    
    private lazy var articleView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.layer.borderColor = Asset.darkThreeHundred.color.cgColor
        return view
    }()
    
    private lazy var articleTextView: UITextView = {
        let textView = UITextView()
        textView.text = article == nil ? "Escreva o artigo aqui" : article?.text
        textView.textAlignment = .left
        textView.font = .systemFont(ofSize: 16, weight: .bold)
        textView.textColor = Asset.darkNineHundred.color
        return textView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitle("Salvar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Asset.green.color
        button.addTarget(self, action: #selector(saveArticlePressed), for: .touchUpInside)
        return button
    }()
    
    init(article: Article? = nil) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    // MARK: - SetupViews and Constraints
    
    private func setupViews() {
        title = article == nil ? "Criar novo artigo" : "Editar artigo"
        view.backgroundColor = .white
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleTextView)
        stackView.addArrangedSubview(subtitleView)
        stackView.addArrangedSubview(articleView)
        
        articleView.addSubview(articleTextView)
        subtitleView.addSubview(subtitleTextView)
        contentView.addSubview(saveButton)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        titleTextView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        subtitleView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
        
        articleTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        subtitleTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.snp.bottomMargin).inset(12)
            make.height.equalTo(48)
        }
    }
    
    private func createNewArticleFor(author: Author) -> Article {
        let id = article == nil ? Reference.randomId : article!.id
        
        return Article(id: id,
                       title: titleTextView.textField.text ?? "",
                       subtitle: subtitleTextView.text,
                       createdAt: Date(),
                       text: articleTextView.text,
                       author: author)
    }
    
    @objc private func saveArticlePressed() {
        Reference.author.document(Reference.userID).getDocument { snapshot, error in
            guard error == nil else {
                return MessageManager.showError(title: "Oops...", subtitle: "Não foi possível salvar o artigo.")
            }
            
            guard let author = try? snapshot?.data(as: Author.self) else { return }
            let article = self.createNewArticleFor(author: author)

            try? Reference.articles.document(article.id).setData(from: article)
            
            self.dismiss(animated: true)
        }
    }
}

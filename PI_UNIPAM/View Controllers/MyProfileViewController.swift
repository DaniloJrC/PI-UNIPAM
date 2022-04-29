//
//  MyProfileViewController.swift
//  PI_UNIPAM
//
//  Created by Danilo Constancio on 25/04/22.
//

import UIKit
import FirebaseAuth

final class MyProfileViewController: ScrollableViewController {
    
    private lazy var profileImageView = ProfileImageView()
  
    private lazy var nameTextView: TextView = {
        let textView = TextView()
        textView.textField.textContentType = .emailAddress
        textView.textField.keyboardType = .emailAddress
        textView.textField.placeholder = "Nome"
        return textView
    }()
    
    private lazy var biographyView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.layer.borderColor = Asset.darkThreeHundred.color.cgColor
        return view
    }()
    
    private lazy var biographyTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Escreva a sua biografia aqui"
        textView.textAlignment = .left
        textView.font = .systemFont(ofSize: 16, weight: .bold)
        textView.textColor = Asset.darkNineHundred.color
        return textView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitle("Salvar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Asset.green.color
        button.addTarget(self, action: #selector(saveProfilePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitle("Sair", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Asset.red.color
        button.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        return button
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    // MARK: - SetupViews and Constraints
    
    private func setupViews() {
        title = "Meu perfil"
        view.backgroundColor = .white
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameTextView)
        contentView.addSubview(biographyView)
        biographyView.addSubview(biographyTextView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(saveButton)
        stackView.addArrangedSubview(logoutButton)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.size.equalTo(110)
        }
        
        nameTextView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        biographyView.snp.makeConstraints { make in
            make.top.equalTo(nameTextView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        biographyTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(biographyView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.snp.bottomMargin).inset(12)
        }
        
        stackView.arrangedSubviews.forEach { button in
            button.snp.makeConstraints { $0.height.equalTo(48) }
        }
    }
    
    private func load() {
        Reference.profileImage.downloadURL { url, _ in
            guard let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return }
            self.profileImageView.image = image
        }
        
        Reference.author.document(Reference.userID).getDocument { snapshot, error in
            guard error == nil else {
                return MessageManager.showError(title: "Oops...", subtitle: "Não foi possível carregar os dados.")
            }
            
            guard let author = try? snapshot?.data(as: Author.self) else { return }
            self.nameTextView.textField.text = author.name
            self.biographyTextView.text = author.biography
        }
    }
    
    @objc private func saveProfilePressed() {
        let author = Author(id: Reference.userID,
                            name: self.nameTextView.textField.text ?? "",
                            createdAt: Date(),
                            biography: biographyTextView.text)
        
        try? Reference.author.document(Reference.userID).setData(from: author)
    }
    
    @objc private func logoutPressed() {
        try? Auth.auth().signOut()
        guard let tabBarController = tabBarController as? TabBarController else { return }
        tabBarController.updateViewControllers()
    }
}

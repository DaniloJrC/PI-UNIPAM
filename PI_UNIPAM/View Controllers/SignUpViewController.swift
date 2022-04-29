//
//  SignUpViewController.swift
//  PI_UNIPAM
//
//  Created by Danilo Constancio on 24/04/22.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "navigation-close-icon"), for: .normal)
        button.addTarget(self, action: #selector(closePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Criar conta"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = Asset.darkNineHundred.color
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var nameTextView: TextView = {
        let textView = TextView()
        textView.textField.textContentType = .name
        textView.textField.keyboardType = .default
        textView.textField.placeholder = "Nome"
        return textView
    }()
    
    private lazy var emailTextView: TextView = {
        let textView = TextView()
        textView.textField.textContentType = .emailAddress
        textView.textField.keyboardType = .emailAddress
        textView.textField.placeholder = "E-mail"
        return textView
    }()
    
    private lazy var passwordTextView: TextView = {
        let textView = TextView()
        textView.textField.textContentType = .password
        textView.textField.keyboardType = .default
        textView.textField.isSecureTextEntry = true
        textView.textField.placeholder = "Senha"
        return textView
    }()
    
    private(set) lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitle("Criar conta", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Asset.blue.color
        button.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = Asset.backgroundColor.color
        view.addSubview(closeButton)
        view.addSubview(stackView)
        stackView.addArrangedSubview(signUpLabel)
        stackView.addArrangedSubview(nameTextView)
        stackView.addArrangedSubview(emailTextView)
        stackView.addArrangedSubview(passwordTextView)
        stackView.addArrangedSubview(signUpButton)
    }
    
    private func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.size.equalTo(40)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        stackView.arrangedSubviews.forEach { textField in
            textField.snp.makeConstraints { $0.height.equalTo(48) }
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
    
    @objc private func closePressed() {
        dismiss(animated: true)
    }
    
    @objc private func signUpPressed() {
        guard let email = emailTextView.textField.text, let password = passwordTextView.textField.text else { return }
        
        guard (nameTextView.textField.text?.count ?? 0) > 4 else {
            return MessageManager.showError(title: "Erro", subtitle: "Verifique os dados inseridos e tente novamente.")
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { _, error  in
            if error != nil {
                return MessageManager.showError(title: "Erro", subtitle: "Não foi possível criar a conta.")
            }
            
            let author = Author(id: Reference.userID,
                                name: self.nameTextView.textField.text ?? "",
                                createdAt: Date(),
                                biography: "")
            
            try? Reference.author.document(Reference.userID).setData(from: author)
            
            let tabBarController = TabBarController()
            tabBarController.modalPresentationStyle = .overCurrentContext
            self.present(tabBarController, animated: true)
        }
    }
}

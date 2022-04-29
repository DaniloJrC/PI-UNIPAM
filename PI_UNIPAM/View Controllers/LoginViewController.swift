//
//  LoginViewController.swift
//  PI_UNIPAM
//
//  Created by Danilo Constancio on 24/04/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "navigation-close-icon"), for: .normal)
        button.addTarget(self, action: #selector(closePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
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
        button.setTitle("Entrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Asset.green.color
        button.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
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
        stackView.addArrangedSubview(loginLabel)
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
    
    @objc private func loginPressed() {
        guard let email = emailTextView.textField.text, let password = passwordTextView.textField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { _,error  in
            if error != nil {
                return MessageManager.showError(title: "Erro", subtitle: "Não foi possível fazer o login.")
            }
            
            let navigationVC = NavigationController()
            navigationVC.setNavigationBarHidden(true, animated: false)
            
            let tabBar = TabBarController()
            navigationVC.setViewControllers([tabBar], animated: true)
            navigationVC.modalPresentationStyle = .overCurrentContext
            self.present(navigationVC, animated: true)
        }
    }
}

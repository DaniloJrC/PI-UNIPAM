//
//  HomeViewController.swift
//  PI UNIPAM
//
//  Created by Danilo Constancio on 24/04/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        tableView.showsVerticalScrollIndicator = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = Asset.backgroundColor.color
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.identifier)
        tableView.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.identifier)
        return tableView
    }()
    
    private var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadArticles()
    }
    
    private func setupViews() {
        title = "Início"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview()}
        tableView.reloadData()
    }
    
    private func loadArticles() {
        Reference.articles.addSnapshotListener { snapshot, error in
            guard error == nil else { return }
            
            do {
                guard let articles = try snapshot?.documents.compactMap({ try $0.data(as: Article.self) }) else { return }
                self.articles = articles
                self.tableView.reloadData()
            } catch {
                MessageManager.showError(title: "Erro", subtitle: "Não foi possível carregar os artigos.")
            }
        }
    }
    
    @objc private func loginPressed() {
        let viewController = LoginViewController()
        viewController.hidesBottomBarWhenPushed = true
        viewController.modalPresentationStyle = .overCurrentContext
        tabBarController?.present(viewController, animated: true)
    }
    
    @objc private func signUpPressed() {
        let viewController = SignUpViewController()
        viewController.hidesBottomBarWhenPushed = true
        viewController.modalPresentationStyle = .overCurrentContext
        tabBarController?.present(viewController, animated: true)
    }
    
    @objc private func readPressed() {
        
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard Reference.currentUser == nil else {
            return 1
        }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard Reference.currentUser == nil else {
            return articles.count
        }
        
        return section == 0 ? 1 : articles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = KeepReadingViewController(article: articles[indexPath.row])
        present(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && Reference.currentUser == nil {
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier, for: indexPath) as? HeaderCell else {
                return UITableViewCell()
            }
            
            headerCell.loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
            headerCell.signUpButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
            return headerCell
        }
        
        guard let articleCell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier, for: indexPath) as? ArticleCell else {
            return UITableViewCell()
        }
        
        articleCell.article = articles[indexPath.row]
        return articleCell
    }
}

//
//  MyArticlesViewController.swift
//  PI_UNIPAM
//
//  Created by Danilo Constancio on 25/04/22.
//

import UIKit

final class MyArticlesViewController: UIViewController {
    
    private lazy var createArticleButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.action = #selector(createArticlePressed)
        button.target = self
        button.image = UIImage(named: "navigation-add-icon")
        return button
    }()
    
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
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadArticles()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = createArticleButtonItem
        setupNavigationBar()
    }
    
    // MARK: - SetupViews and Constraints
    
    private func setupViews() {
        title = "Meus artigos"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview()}
    }
    
    private func loadArticles() {
        guard let id = Reference.currentUser?.uid else { return }
        
        Reference.articles.whereField("author.id", isEqualTo: id).addSnapshotListener { snapshot, error in
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
    
    @objc private func createArticlePressed() {
        present(NavigationController(rootViewController: CreateArticleViewController()), animated: true)
    }
}

extension MyArticlesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = KeepReadingViewController(article: articles[indexPath.row])
        present(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Deletar") { _, _, _ in
            let article = self.articles[indexPath.row]
            
            Reference.articles.document(article.id).delete()
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Editar") { _, _, _ in
            let article = self.articles[indexPath.row]
            
            self.present(NavigationController(rootViewController: CreateArticleViewController(article: article)), animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let articleCell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier, for: indexPath) as? ArticleCell else {
            return UITableViewCell()
        }
        
        articleCell.article = articles[indexPath.row]
        return articleCell
    }
}

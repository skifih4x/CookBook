//
//  SavedRecipesViewController.swift
//  СookBook
//
//  Created by Артем Галай on 28.11.22.
//

import UIKit

final class SavedRecipesViewController: UIViewController {
    
    private lazy var savedRecipesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SavedRecipesCell.self, forCellReuseIdentifier: SavedRecipesCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Saved recipes"
        view.addSubview(savedRecipesTableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        savedRecipesTableView.frame = view.bounds
    }
}

extension SavedRecipesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedRecipesCell.identifier, for: indexPath) as? SavedRecipesCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension SavedRecipesViewController: UITableViewDelegate {
}

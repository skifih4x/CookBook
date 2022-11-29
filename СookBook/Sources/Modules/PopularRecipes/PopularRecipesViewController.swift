//
//  PopularRecipesViewController.swift
//  СookBook
//
//  Created by Артем Орлов on 28.11.2022.
//

import UIKit

final class PopularRecipesViewController: UIViewController {

    let sectionTitles: [String] = ["Popular", "Trending", "Top rated"]

    private lazy var recipesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self,
                           forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Команда 4"
        setupHierarchy()
        setupLayout()
    }

    private func setupHierarchy() {
        view.addSubview(recipesTableView)

    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            recipesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            recipesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension PopularRecipesViewController: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }

}

extension PopularRecipesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }
}

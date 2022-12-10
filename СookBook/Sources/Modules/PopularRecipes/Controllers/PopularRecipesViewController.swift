//
//  PopularRecipesViewController.swift
//  СookBook
//
//  Created by Артем Орлов on 28.11.2022.
//

import UIKit

final class PopularRecipesViewController: UIViewController {

    let sectionTitles = ["Trending now🔥", "Popular"]

    var popular = [Dish]()
    var trending = [Dish]()
    var topRated = [Dish]()

    private lazy var recipesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self,
                           forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        //        title = "Команда 4"
        setupHierarchy()
        setupLayout()

        fetchRecipes { [weak self] model in
            self?.popular = model
        }

        fetchRecipes { [weak self] model in
            self?.trending = model
        }

        fetchRecipes { [weak self] model in
            self?.topRated = model
        }
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

    func fetchRecipes(completion: @escaping ([Dish]) -> ()) {
        NetworkService.shared.fetchRandomDishes() { [weak self] result in
            switch result {
            case .success(let data):
                completion(data)
                self?.recipesTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
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

        switch indexPath.section {
        case 0:
            cell.configure(with: popular)
        case 1:
            cell.configure(with: trending)
        case 2:
            cell.configure(with: topRated)
        default:
            return UITableViewCell()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        header.backgroundColor = .secondarySystemBackground

        let label = UILabel(frame: CGRect(x: 10, y: -20, width: 160, height: header.frame.size.height - 10))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = sectionTitles[section]
        label.font = .systemFont(ofSize: 20, weight: .bold)

        let button = UIButton(frame: CGRect(x: 250, y: -20, width: 160, height: header.frame.size.height - 10))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("See all →", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.tag = section

        header.addSubview(label)
        header.addSubview(button)

        return header
    }

    @objc func buttonAction(button: UIButton) {
        let section = button.tag

        switch section {
        case 0:
            let vc = TrendingViewController()
            vc.a(m: popular)
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = TrendingViewController()
            vc.a(m: trending)
            navigationController?.pushViewController(vc, animated: true)
        default:
            ""
        }


    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset

        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

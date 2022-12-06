//
//  PopularRecipesViewController.swift
//  СookBook
//
//  Created by Артем Орлов on 28.11.2022.
//

import UIKit

final class PopularRecipesViewController: UIViewController {

    let sectionTitles: [String] = ["Popular", "Trending", "Top rated"]

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

        
        NetworkService.shared.fetchRandomDishesIngridients(dishId: 1113485) { [weak self] result in
            switch result {
            case .success(let data):
                //print(data[0].image?.asUrlImage)
                print("мы получаем : \(data)")
            case .failure(let error):
                print(error)
                
            }
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
        20
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset

        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

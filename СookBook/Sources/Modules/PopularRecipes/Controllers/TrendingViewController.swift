//
//  TrendingViewController.swift
//  СookBook
//
//  Created by Артем Орлов on 05.12.2022.
//

import UIKit
import Kingfisher

class TrendingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tranding = [Dish]()

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self

        fetchRecipes { [weak self] model in
            self?.tranding = model
        }

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    func fetchRecipes(completion: @escaping ([Dish]) -> ()) {
        NetworkService.shared.fetchRandomDishes() { [weak self] result in
            switch result {
            case .success(let data):
                completion(data)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tranding.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let modelTv = tranding[indexPath.row].image?.asUrl
        cell.imageView?.kf.setImage(with: modelTv)


        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

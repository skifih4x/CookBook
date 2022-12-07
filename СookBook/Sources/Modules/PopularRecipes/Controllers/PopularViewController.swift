//
//  PopularViewController.swift
//  СookBook
//
//  Created by Артем Орлов on 05.12.2022.
//

import UIKit

class PopularViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var popular = [Dish]()

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
            self?.popular = model
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
        popular.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let modelMovie = popular[indexPath.row].image

            DispatchQueue.global().async {
                guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(modelMovie ?? "")" ) else {return}
                guard let imageData = try? Data(contentsOf: url) else {return}
                DispatchQueue.main.async {
                    cell.imageView?.image = UIImage(data: imageData)
                }
            }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}



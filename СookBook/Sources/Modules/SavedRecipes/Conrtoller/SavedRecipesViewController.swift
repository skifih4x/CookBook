//
//  SavedRecipesViewController.swift
//  СookBook
//
//  Created by Артем Галай on 28.11.22.
//

import UIKit

final class SavedRecipesViewController: UIViewController {
    var dishRandom = [Dish]()
    
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
        
        fetchRecipes { [weak self] model in
            self?.dishRandom = model
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        savedRecipesTableView.frame = view.bounds
    }
    
    func fetchRecipes(completion: @escaping ([Dish]) -> ()) {
        NetworkService.shared.fetchRandomDishes() { [weak self] result in
            switch result {
            case .success(let data):
                completion(data)
                self?.savedRecipesTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension SavedRecipesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dishRandom.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedRecipesCell.identifier, for: indexPath) as? SavedRecipesCell else { return UITableViewCell() }
        
        cell.configure(contact: dishRandom[indexPath.row])
        
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
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, complete in
                
                
                self?.dishRandom.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                complete(true)
            }
            deleteAction.backgroundColor = .red

            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
}

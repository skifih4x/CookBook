//
//  TrendingViewController.swift
//  СookBook
//
//  Created by Артем Орлов on 05.12.2022.
//

import UIKit
import Kingfisher

class TrendingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var trandingVC = [Dish]()
    var dishId = [Dish]()

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TrendingCell.self, forCellReuseIdentifier: TrendingCell.identifier)
        table.separatorStyle = .none
        table.backgroundColor = .white

        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

        let button = UIButton(type: .custom)

        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.imageView?.tintColor = .black
        button.addTarget(self, action: #selector(callMethod), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.sizeToFit()


        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton

        navigationController?.navigationBar.barTintColor = .white

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnTap = false
        navigationItem.hidesSearchBarWhenScrolling = false

    }

    @objc func callMethod(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated:true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        tableView.frame = view.bounds

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trandingVC.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingCell.identifier, for: indexPath) as? TrendingCell else { return  UITableViewCell() }
        cell.setup(model: trandingVC[indexPath.row])
        cell.selectionStyle = .none

        return cell
    }

    func a(m: [Dish]) {
        trandingVC = m

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        214
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        dishId = [trandingVC[indexPath.row]]
        
        let vc = DetalViewController()
        vc.dish = dishId
        navigationController?.pushViewController(vc, animated: true)
    }
}

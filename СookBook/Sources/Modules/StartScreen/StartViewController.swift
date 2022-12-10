//
//  StartViewController.swift
//  СookBook
//
//  Created by Артем Галай on 9.12.22.
//

import UIKit

class StartViewController: UIViewController {

    private lazy var backgroundView: UIImageView = {
        let imageViewBackground = UIImageView(frame: UIScreen.main.bounds)
        imageViewBackground.image = UIImage(named: "firstScreen")
        return imageViewBackground
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get recipes", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupLayout()
        navigationController?.isNavigationBarHidden = true
    }

    private func setupHierarchy() {
        view.addSubview(backgroundView)
        view.addSubview(startButton)

    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 150),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc func buttonTapped() {
        navigationController?.pushViewController(CookTabBarController(), animated: true)
    }
}

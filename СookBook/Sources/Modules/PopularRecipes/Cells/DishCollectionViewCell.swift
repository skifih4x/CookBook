//
//  DishCollectionViewCell.swift
//  СookBook
//
//  Created by Артем Галай on 1.12.22.
//

import UIKit
import Kingfisher

class DishCollectionViewCell: UICollectionViewCell {

    static let identifier = "DishCollectionViewCell"

    private let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let likesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yellow
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarchy() {
        addSubview(dishImageView)
        addSubview(titleLabel)
        addSubview(likesLabel)

    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: topAnchor),
            dishImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dishImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dishImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60),

            titleLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            likesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            likesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            likesLabel.heightAnchor.constraint(equalToConstant: 20),
            likesLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    func configure(with model: Dish) {
        dishImageView.kf.setImage(with: model.image?.asUrl)
        titleLabel.text = model.title
        likesLabel.text = String(describing: model.aggregateLikes ?? 0)
    }
}

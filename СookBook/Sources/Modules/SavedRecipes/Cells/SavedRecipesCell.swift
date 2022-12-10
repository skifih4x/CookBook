//
//  SavedRecipesCell.swift
//  СookBook
//
//  Created by Артем Галай on 10.12.22.
//

import UIKit

class SavedRecipesCell: UITableViewCell {

    static let identifier = "DishCollectionViewCell"

    private let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "firstScreen")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Name recipe"
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let viewForLikes: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.7
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let likeImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "heart.fill")
        imageView.image = image
        imageView.tintColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let likesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var fovouriteMarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        button.imageView?.layer.transform = CATransform3DMakeScale(1.4, 1.4, 1.4)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarchy() {
        addSubview(dishImageView)
        addSubview(titleLabel)
        addSubview(viewForLikes)
        addSubview(fovouriteMarkButton)
        viewForLikes.addSubview(likeImage)
        viewForLikes.addSubview(likesLabel)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: topAnchor),
            dishImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dishImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            dishImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),

            titleLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            fovouriteMarkButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            fovouriteMarkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            viewForLikes.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            viewForLikes.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            viewForLikes.heightAnchor.constraint(equalToConstant: 22),
            viewForLikes.widthAnchor.constraint(equalToConstant: 62),

            likeImage.centerYAnchor.constraint(equalTo: viewForLikes.centerYAnchor),
            likeImage.leadingAnchor.constraint(equalTo: viewForLikes.leadingAnchor, constant: 2),
            likeImage.heightAnchor.constraint(equalToConstant: 22),
            likeImage.widthAnchor.constraint(equalToConstant: 22),

            likesLabel.centerYAnchor.constraint(equalTo: viewForLikes.centerYAnchor),
            likesLabel.leadingAnchor.constraint(equalTo: likeImage.trailingAnchor),
            likesLabel.trailingAnchor.constraint(equalTo: viewForLikes.trailingAnchor, constant: -2)
        ])
    }
}

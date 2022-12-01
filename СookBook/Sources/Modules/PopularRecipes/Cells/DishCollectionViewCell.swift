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
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(dishImageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        dishImageView.frame = contentView.bounds
    }

//    override func prepareForReuse() {
//        super.prepareForReuse()
//        dishImageView.image = nil
//    }


    func configure(with model: String) {
        dishImageView.kf.setImage(with: model.asUrl)
    }
}

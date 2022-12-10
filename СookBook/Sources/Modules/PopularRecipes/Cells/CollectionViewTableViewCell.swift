//
//  CollectionViewTableViewCell.swift
//  СookBook
//
//  Created by Артем Галай on 29.11.22.
//

import UIKit

protocol CollectionViewTableViewCellDelegate : class {
    func categoryTapped(_ cell: CollectionViewTableViewCell)
}

final class CollectionViewTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionViewTableViewCell"
    static var dishId = [Dish]()
    
    private var dish = [Dish]()
    
    
    var delegate : CollectionViewTableViewCellDelegate?
   
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 300)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DishCollectionViewCell.self, forCellWithReuseIdentifier: DishCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemGray6
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    func configure(with dish: [Dish]) {
        self.dish = dish
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
//    func configureTop(with dish: [TopPop]) {
//        self.dish = dish
//        DispatchQueue.main.async { [weak self] in
//            self?.collectionView.reloadData()
//        }
//    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate {
    
}

extension CollectionViewTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dish.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        CollectionViewTableViewCell.dishId = [dish[indexPath.row]]
        
            if delegate != nil {
            delegate?.categoryTapped(self)
            }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCollectionViewCell.identifier, for: indexPath) as? DishCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.configure(with: dish[indexPath.row])
        
        return cell
    }
}

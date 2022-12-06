

import UIKit

class VegetableCell: UITableViewCell {

    let avatar = UIImageView()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    } ()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
    }
      
    // нстройки для элементов внутри ячейки
    private func setupCell() {
        [avatar,nameLabel,descriptionLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        contentView.backgroundColor = #colorLiteral(red: 0.9467813373, green: 0.9467813373, blue: 0.9467813373, alpha: 1)
        contentView.layer.cornerRadius = 20
        
        
        
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            avatar.heightAnchor.constraint(equalToConstant: 32),
            avatar.widthAnchor.constraint(equalToConstant: 32),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 10 ),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            

            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor,  constant: 250),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        
        
    }

    // настраиваем читку
    func configure(contact: Ingridients) {
        avatar.kf.setImage(with: contact.image?.asUrlImage)
        nameLabel.text = contact.name
        //descriptionLabel.text = contact.
    }
    
}

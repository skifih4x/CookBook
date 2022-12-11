
import UIKit

class DetalViewController: UIViewController {
    
    
    var labelNameDish = UILabel()
    var photoDish = UIImageView()
    var image = UIImage(named: "vagyu.jpg")
    let likeLabel = UILabel()
    let descriptionDish = UILabel()
    let howMakeLabel = UILabel()
    let countIngrLabel = UILabel()
    var vegetabls = [Ingridients]()
    var dishDetail = [Results]()
    var dish = [Dish]()
    
    var tableView: UITableView = .init()

    let stackView = UIStackView()
    var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setcutstaint()
        
        self.view.backgroundColor = .white
        

        
        tableView.register(VegetableCell.self, forCellReuseIdentifier: "VegetableCell")

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        ingridientsFatch()
        ingrDetailFetch()
        
        let button = UIButton(type: .custom)

        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.imageView?.tintColor = .black
        button.addTarget(self, action: #selector(callMethod), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.sizeToFit()


        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
        navigationController?.hidesBarsOnTap = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    @objc func callMethod(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated:true)
    }
    private func ingridientsFatch() {

        NetworkService.shared.fetchRandomDishesIngridients(dishId: dish[0].id ?? 0) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.vegetabls = data
                    self?.tableView.reloadData()
                    print("мы получаем : \(self?.vegetabls ?? [Ingridients]())")
                case .failure(let error):
                    print(error)

                }
            }

        }
    
    private func ingrDetailFetch() {
        
        let urlString = Rout.baseUrl + Rout.getIngridients(dish[0].id ?? 0).description + Rout.apiKey
        NetworkService.shared.fetchCharacter(urlString: urlString ) { [weak self] result  in
            switch result {
            case .success(let data):
                self?.dishDetail = [data]
                self?.tableView.reloadData()
                //print(self?.dishDetail.count)
               print("=============================\(self?.dishDetail)")
            case .failure(let error):
                print(error)
                
            }
        }
        
        
    }

}



extension DetalViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vegetabls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VegetableCell", for: indexPath) as? VegetableCell else { fatalError() }

        guard let index = dishDetail.first?.ingredients[indexPath.row] else { return cell }
        
        cell.configures(contact: index)
        cell.configure(contact: vegetabls[indexPath.row])
        cell.selectionStyle = .none
        

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 10, y: 0, width: tableView.frame.width, height: 30))
        headerView.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width, height: headerView.frame.height)
        label.text = "Ингридиенты"
        //            label.font = .systemFont(ofSize: 20)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        label.textColor = .black
        headerView.addSubview(label)

        let CountLabel = UILabel()
        CountLabel.frame = CGRect.init(x:  3 * headerView.frame.width/4, y: 5, width: headerView.frame.width, height: headerView.frame.height)
        CountLabel.text = "\(vegetabls.count) items"
        CountLabel.font = .systemFont(ofSize: 15)
        CountLabel.textColor = .black
        CountLabel.alpha = 0.8
        headerView.addSubview(CountLabel)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 50

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70

    }
    
}


extension DetalViewController: UITableViewDelegate {
    
}




extension DetalViewController {
    func setup () {
        setuplabelNameDish()
        setupPhotoDish()
        setupLikeLabel()
        setupdescriptionDish()
        setupHowMakeLabel()
        // setupcountIngrLabel()
    }
}


extension DetalViewController {
    func setupHowMakeLabel() {
        howMakeLabel.textColor = .black
        howMakeLabel.numberOfLines = 0
        howMakeLabel.text = "\(dish[0].instructions ?? "")"
        howMakeLabel.font = howMakeLabel.font.withSize(15)
        stackView.addSubview(howMakeLabel)
    }
}


extension DetalViewController {
    func setupcountIngrLabel() {
        
        countIngrLabel.textColor = .black
        countIngrLabel.numberOfLines = 0
        countIngrLabel.text = "23 rf"
        countIngrLabel.font = countIngrLabel.font.withSize(15)
        stackView.addSubview(countIngrLabel)
    }
}

extension DetalViewController {
    
    func setupdescriptionDish() {
        
        descriptionDish.textColor = .black
        descriptionDish.numberOfLines = 0
        descriptionDish.text = ""
        descriptionDish.font = descriptionDish.font.withSize(15)
        stackView.addSubview(descriptionDish)
        
    }
    
    
}

extension DetalViewController {
    
    func setupLikeLabel() {
        
        
        likeLabel.textColor = .black
        likeLabel.numberOfLines = 0
        likeLabel.text = "\(dish[0].aggregateLikes ?? 0) ❤️"
        likeLabel.font = likeLabel.font.withSize(18)
        stackView.addSubview(likeLabel)
    }
    
    
}




extension DetalViewController {
    
    func setuplabelNameDish() {
        
        labelNameDish.textColor = .black
        labelNameDish.numberOfLines = 0

        labelNameDish.text = "How to make a \(dish[0].title ?? "") "

        //        labelNameDish.font = labelNameDish.font.withSize(22)
        labelNameDish.font = UIFont(name:"HelveticaNeue-Bold", size: 22.0)
        stackView.addSubview(labelNameDish)
    }
    
    
}


extension DetalViewController {
    func setupPhotoDish() {
        
        
        photoDish.kf.setImage(with: dish[0].image?.asUrl)
        photoDish.layer.cornerRadius = 23
        photoDish.clipsToBounds = true
        photoDish.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        photoDish.widthAnchor.constraint(equalToConstant: 200.0).isActive = true

        stackView.addSubview(photoDish)
    }
}


extension DetalViewController {
    func  setcutstaint() {
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing   = 10.0
        
        stackView.addArrangedSubview(labelNameDish)
        stackView.addArrangedSubview(photoDish)
        stackView.addArrangedSubview(likeLabel)
        stackView.addArrangedSubview(descriptionDish)
        stackView.addArrangedSubview(howMakeLabel)
        stackView.addArrangedSubview(countIngrLabel)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        
        
        stackView.addArrangedSubview(labelNameDish)
        stackView.addArrangedSubview(photoDish)
        stackView.addArrangedSubview(likeLabel)
        stackView.addArrangedSubview(descriptionDish)
        stackView.addArrangedSubview(howMakeLabel)
        stackView.addArrangedSubview(countIngrLabel)
        
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        self.view.addSubview(tableView)
        
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor,constant: 80).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.frame.height / 3 - 10) ).isActive = true
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            tableView.topAnchor.constraint(equalTo: view.bottomAnchor,constant: -(view.frame.height / 3)),//-310
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 2000)
        
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        
        photoDish.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
        
        labelNameDish.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        labelNameDish.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        labelNameDish.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        
        photoDish.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        photoDish.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        photoDish.topAnchor.constraint(equalTo: labelNameDish.bottomAnchor,constant: 27).isActive = true
        
        likeLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        likeLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        likeLabel.topAnchor.constraint(equalTo: photoDish.bottomAnchor,constant: 10).isActive = true
        
        
        descriptionDish.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        descriptionDish.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        descriptionDish.topAnchor.constraint(equalTo: likeLabel.bottomAnchor,constant: 27).isActive = true
        
        howMakeLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        howMakeLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        howMakeLabel.topAnchor.constraint(equalTo: descriptionDish.bottomAnchor,constant: 27).isActive = true
        
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
}

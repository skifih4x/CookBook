
import UIKit

class DetalViewController: UIViewController {


    

    var labelNameDish = UILabel()
    var photoDish = UIImageView()
    var image = UIImage(named: "vagyu.jpg")
    let likeLabel = UILabel()
    let descriptionDish = UILabel()
    let howMakeLabel = UILabel()
    let countIngrLabel = UILabel()
    var vegetabls = Sourse.makeContacts()
    var tableView: UITableView = .init()
    let stackView   = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        
        
        
        tableView.register(VegetableCell.self
                           , forCellReuseIdentifier: "VegetableCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        
        
        
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
        
        self.view.addSubview(stackView)
        
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70) ,
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30) ,
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30) ,
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.frame.height / 3 - 10) ) // -300
            ])
        
        
        photoDish.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    
    
    
    
    
        
    }


 

extension DetalViewController: UITableViewDataSource {
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vegetabls.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VegetableCell", for: indexPath) as? VegetableCell else { fatalError() }

        cell.configure(contact: vegetabls[indexPath.row] )
    
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
        CountLabel.text = "12 items"
        CountLabel.font = .systemFont(ofSize: 15)
        CountLabel.textColor = .black
        CountLabel.alpha = 0.8
        headerView.addSubview(CountLabel)
        
        
        
        
        
            return headerView
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
    
}


extension DetalViewController: UITableViewDelegate {
    
}

extension DetalViewController {
    func setupTableView() {
        view.addSubview(tableView)
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            tableView.topAnchor.constraint(equalTo: view.bottomAnchor,constant: -(view.frame.height / 3)),//-310
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
        
    }
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
        howMakeLabel.text = "1234123412 grhkfdg[khd'fg fgjh [d[fgваыхзпшdgfsgdsfgdsfgdfgdfgdfgfgfdghdfghfdghfdghdfghdfghfdghfdghfdghfdghfghроывашоп оахп выаопыв оп"
        howMakeLabel.font = howMakeLabel.font.withSize(15)
        self.view.addSubview(howMakeLabel)
    }
}


extension DetalViewController {
    func setupcountIngrLabel() {

        countIngrLabel.textColor = .black
        countIngrLabel.numberOfLines = 0
        countIngrLabel.text = "23 rf"
        countIngrLabel.font = countIngrLabel.font.withSize(15)
        self.view.addSubview(countIngrLabel)
    }
}

extension DetalViewController {
    
    func setupdescriptionDish() {

        descriptionDish.textColor = .black
        descriptionDish.numberOfLines = 0
        descriptionDish.text = "Здесь будет описание блюда idfuhgpidfhghadfgh[adf[ghau[dfhgadhfgadfgh[afh[gadfoh[h  jdfg;dgjsdfgsdfhjghdsfhg;dshfjhsdjgfghdfghfdghfdghfghfdghh;sdjfhg;sdfh;gsdhf;gdsh;fgj"
        descriptionDish.font = descriptionDish.font.withSize(15)
        self.view.addSubview(descriptionDish)

    }
    
    
}

extension DetalViewController {
    
    func setupLikeLabel() {

        likeLabel.textColor = .black
        likeLabel.numberOfLines = 0
        likeLabel.text = "❤️ 34 "
        likeLabel.font = likeLabel.font.withSize(12)
        self.view.addSubview(likeLabel)
    }
    
    
}




extension DetalViewController {
    
    func setuplabelNameDish() {

        labelNameDish.textColor = .black
        labelNameDish.numberOfLines = 0
        labelNameDish.text = "How to make ... авпвап вапвывпа вап"
//        labelNameDish.font = labelNameDish.font.withSize(22)
        labelNameDish.font = UIFont(name:"HelveticaNeue-Bold", size: 22.0)
        self.view.addSubview(labelNameDish)
    }
    
    
}


extension DetalViewController {
    func setupPhotoDish() {

        
        photoDish.image = image
        photoDish.layer.cornerRadius = 23
        photoDish.clipsToBounds = true
        photoDish.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        photoDish.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
      
        self.view.addSubview(photoDish)
    }
}

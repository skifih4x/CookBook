
import Foundation
import UIKit


struct InfoVeget {
    let name: String
    let image: UIImage
    let desctiption: String

}

struct ImageName {
    static let vegetabls = "person"
    static let fillImage = "person.fill"
}


struct Description {
    static let description = "10g"
    static let description2 = "20g"
}


struct Sourse {
    static func makeContacts() -> [InfoVeget] {
        [
            
            .init(name: "Лук", image: .init(systemName: ImageName.vegetabls)!, desctiption: Description.description),
            .init(name: "Морковь", image: .init(systemName: ImageName.vegetabls)!, desctiption: Description.description),
            .init(name: "Свекла", image: .init(systemName: ImageName.vegetabls)!, desctiption: Description.description),
            
            .init(name: "Огурец", image: .init(systemName: ImageName.vegetabls)!, desctiption: Description.description),
            .init(name: "Имбирь", image: .init(systemName: ImageName.vegetabls)!, desctiption: Description.description),
            .init(name: "перерц", image: .init(systemName: ImageName.vegetabls)!, desctiption: Description.description)

            
        ]
    }
    
    

}



//
//  Route.swift
//  ApiTest
//
//  Created by Админ on 29.11.2022.
//

import Foundation

enum Rout {
    
    static let baseUrl = "https://api.spoonacular.com"
    static let apiKey = "apiKey=602e4ffc344843c4a5af8b63fefa097b"
    
    case getRandomDish
    case getIngridients(String)
    
    var description: String {
        switch self {
            
        case .getRandomDish:
            return "/recipes/random?number=1&tags&"
        case .getIngridients(let dishId):
            return "/recipes/\(dishId)/ingredientWidget.json?"
        }
        
    }
}

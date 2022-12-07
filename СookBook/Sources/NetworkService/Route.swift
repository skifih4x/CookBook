//
//  Route.swift
//  ApiTest
//
//  Created by Админ on 29.11.2022.
//

import Foundation

enum Rout {
    
    static let baseUrl = "https://api.spoonacular.com"
    static let apiKey = "apiKey=43752d729e6042f99943ba1d9df48ce5"
    
    case getRandomDish
    case getIngridients(Int)
    
    var description: String {
        switch self {
            
        case .getRandomDish:
            return "/recipes/random?number=10&tags&"
        case .getIngridients(let dishId):
            return "/recipes/\(dishId)/ingredientWidget.json?"
        }
        
    }
}

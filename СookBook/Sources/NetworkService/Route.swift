//
//  Route.swift
//  ApiTest
//
//  Created by Админ on 29.11.2022.
//

import Foundation

enum Rout {
    
    static let baseUrl = "https://api.spoonacular.com"
    static let apiKey = "apiKey=5bef6d96d4974fec9375c4f709c5152f"
    
    case getRandomDish
    case getIngridients(String)
    
    var description: String {
        switch self {
            
        case .getRandomDish:
            return "/recipes/random?number=10&tags&"
        case .getIngridients(let dishId):
            return "/recipes/\(dishId)/ingredientWidget.json?"
        }
        
    }
}

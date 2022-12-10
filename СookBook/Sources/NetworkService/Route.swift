//
//  Route.swift
//  ApiTest
//
//  Created by Админ on 29.11.2022.
//

import Foundation

enum Rout {
    
    static let baseUrl = "https://api.spoonacular.com"

    static let apiKey = "apiKey=9b653496de634f8bb17c68897a4a6c52"

    
    case getRandomDish
    case getIngridients(Int)
    case getRandomVegan
    case getRandomDessert
    
    var description: String {
        switch self {
            
        case .getRandomDish:
            return "/recipes/random?number=10&tags&"
        case .getIngridients(let dishId):
            return "/recipes/\(dishId)/ingredientWidget.json?"
        case .getRandomVegan:
            return "/recipes/random?number=10&tags=vegan&"
        case .getRandomDessert:
            return "/recipes/random?number=10&tags=dessert&"
        }

        
    }
}

//
//  ApiResponse.swift
//  ApiTest
//
//  Created by Админ on 29.11.2022.
//

import Foundationё


struct ApiResponse<T:Decodable>: Decodable {
    
    let ingredients, recipes: T?
    let error: String?
    
}

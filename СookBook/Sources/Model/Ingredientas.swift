//
//  Ingredientas.swift
//  ApiTest
//
//  Created by Админ on 29.11.2022.
//

import Foundation
 
struct Ingridients: Decodable {
    
    //let ingredients: [Metric]?
    let value: Int?
    let name, image, unit: String?
    //let amount: [Metric]?
}

struct Metric: Decodable {
    
    //let name, image: String?
//    let image: String?
//    //let amount: [Amount]?
    let value: Int?
    let unit: String?
    
}

struct Amount: Decodable {

    let metric: [Metric]?


}

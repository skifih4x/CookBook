//
//  Amount+Ingridients.swift
//  СookBook
//
//  Created by Админ on 10.12.2022.
//

import Foundation

struct Results: Decodable {
    
    let ingredients: [Ingridient]
 
}

struct Ingridient: Decodable {
    
    let amount: Amount
   
}

struct Amount: Decodable  {

    let metric: Metrics

}

struct Metrics: Decodable {
    
    let value: Double
    let unit: String
}



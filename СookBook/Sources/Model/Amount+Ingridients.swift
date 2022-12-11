//
//  Amount+Ingridients.swift
//  СookBook
//
//  Created by Админ on 10.12.2022.
//

import Foundation

struct Results: Codable {
    
    let ingredients: [Ingridient]
 
}

struct Ingridient: Codable {
    
    let amount: Amount
   
}

struct Amount: Codable  {
    
    let metric : Metrics
    
}

struct Metrics: Codable {
    
    let value: Double
    let unit: String
}



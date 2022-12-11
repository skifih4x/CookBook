//
//  String+Extension.swift
//  ApiTest
//
//  Created by Админ on 29.11.2022.
//

import Foundation

extension String {
    
    var asUrl: URL? {
        return URL(string: self)
    }
}

extension String {
    
    var asUrlImage: URL? {
        return URL(string: "https://spoonacular.com/cdn/ingredients_100x100/" + self)
    }
}

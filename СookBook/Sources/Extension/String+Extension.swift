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


extension String {
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return NSAttributedString()
        }
        
        do {
            return try NSAttributedString(data: data, options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}


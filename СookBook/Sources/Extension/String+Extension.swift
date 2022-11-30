//
//  String+Extension.swift
//  ApiTest
//
//  Created by Админ on 29.11.2022.
//

import Foundation

extension String {
    
    var asUrl:URL? {
        return URL(string: self)
    }
}

//
//  APIError.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 8/5/24.
//

import Foundation

enum APIError: Error {
    case error(String)
    
    var localizedDescription: String {
        switch self {
        case .error(let string):
            return string
            
        }
    }
}

//
//  ObjectSavableError.swift
//  kompas.id-submission
//
//  Created by Galang Aji Susanto on 24/01/22.
//

import Foundation

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}

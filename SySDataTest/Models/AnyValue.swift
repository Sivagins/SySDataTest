//
//  AnyValue.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import Foundation

enum AnyValue: Decodable {
    
    case int(Int), string(String)
    
    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        throw AnyError.missingValue
    }
    
    enum AnyError: Error {
        case missingValue
    }
}

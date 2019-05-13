//
//  ResponseModel.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import Foundation

struct ResponseModel<T: Decodable>: Decodable {
    var results: [T]
}

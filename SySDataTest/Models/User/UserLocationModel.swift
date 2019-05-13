//
//  UserLocationModel.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import Foundation

struct UserLocationModel: Decodable {
    var street: String
    var city: String
    var state: String
    var postcode: AnyValue
}

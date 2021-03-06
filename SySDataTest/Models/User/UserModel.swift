//
//  UserModel.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import Foundation

struct UserModel: Decodable {
    var email: String
    var phone: String
    var picture: PictureModel
    var name: UserNameModel
    var location: UserLocationModel
}

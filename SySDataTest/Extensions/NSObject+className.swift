//
//  File.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import Foundation

extension NSObject {
    
    static var className: String {
        return String(describing: self)
    }
}

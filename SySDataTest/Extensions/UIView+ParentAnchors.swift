//
//  UIView+ParentAnchors.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 17/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setupAnchors(for targetView: UIView) {
        targetView.translatesAutoresizingMaskIntoConstraints = false
        targetView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        targetView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        targetView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        targetView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
    }
}

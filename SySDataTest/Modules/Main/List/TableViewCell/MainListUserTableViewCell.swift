//
//  MainListUserTableViewCell.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import UIKit

class MainListUserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    func setup(with user: UserModel) {
        let name = user.name
        nameLabel.text = String(format: "%@ %@", name.first, name.last)
        locationLabel.text = user.location.city
        phoneLabel.text = user.phone
    }
}

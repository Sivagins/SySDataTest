//
//  MainListUserCollectionViewCell.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import UIKit

class MainListUserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBorder()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.sd_cancelCurrentImageLoad()
        avatarImageView.image = nil
        nameLabel.text = ""
        locationLabel.text = ""
        phoneLabel.text = ""
    }
    
    private func setupBorder() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
    }
    
    func setup(with user: UserModel) {
        let name = user.name
        nameLabel.text = String(format: "%@ %@", name.first, name.last)
        locationLabel.text = user.location.city
        phoneLabel.text = user.phone
        guard let avatarURL = URL(string: user.picture.medium) else {
            return
        }
        avatarImageView.sd_setImage(with: avatarURL, completed: nil)
    }
}

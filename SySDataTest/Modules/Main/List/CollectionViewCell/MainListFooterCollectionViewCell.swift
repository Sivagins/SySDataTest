//
//  MainListFooterCollectionViewCell.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 17/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import UIKit

class MainListFooterCollectionViewCell: UICollectionViewCell {
    
    func setup(with loaderView: UIView) {
        addSubview(loaderView)
        setupAnchors(for: loaderView)
    }
}

//
//  BaseViewController.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    
    func showLoading() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func hideLoading() {
        MBProgressHUD.hide(for: view, animated: true)
    }
}

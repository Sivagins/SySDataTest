//
//  Coordinator.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import Foundation
import UIKit

class Coordinator: NSObject {
    
    var presenter: UINavigationController
    
    override init() {
        presenter = UINavigationController()
        super.init()
        start()
    }
    
    private func start() {
        let viewModel = MainPickerViewModel(coordinator: self)
        let viewController = MainPickerViewController(viewModel: viewModel)
        presenter.pushViewController(viewController, animated: true)
    }
    
    func showList() {
        let viewModel = MainListViewModel(coordinator: self)
        let viewController = MainListViewController(viewModel: viewModel)
        presenter.pushViewController(viewController, animated: true)
    }
    
    func showGrid() {
        let viewModel = MainListViewModel(coordinator: self, type: .grid)
        let viewController = MainListViewController(viewModel: viewModel)
        presenter.pushViewController(viewController, animated: true)
    }
    
    func showProfile(user: UserModel) {
        let viewModel = MainProfileViewModel(coordinator: self, user: user)
        let viewController = MainProfileViewController(viewModel: viewModel)
        presenter.pushViewController(viewController, animated: true)
    }
    
    func back() {
        presenter.popViewController(animated: true)
    }
}

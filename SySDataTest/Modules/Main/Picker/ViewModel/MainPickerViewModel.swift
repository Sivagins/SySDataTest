//
//  MainPickerViewModel.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import Foundation

protocol MainPickerViewModelProtocol {
    func showList()
    func showCollection()
}

class MainPickerViewModel: MainPickerViewModelProtocol, BaseViewModel {
    
    var coordinator: Coordinator
    var dataManager: DataManager
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        self.dataManager = DataManager()
    }
    
    func showList() {
        coordinator.showList()
    }
    
    func showCollection() {
        coordinator.showGrid()
    }
}

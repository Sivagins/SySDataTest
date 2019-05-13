//
//  MainProfileViewController.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import Foundation

protocol MainProfileViewModelProtocol {
    func getName() -> String
    func getLocation() -> String
    func getAvatarPath() -> String
    func getMail() -> String
    func getPhone() -> String
}

class MainProfileViewModel: MainProfileViewModelProtocol, BaseViewModel {
    
    private var user: UserModel
    
    var coordinator: Coordinator
    var dataManager: DataManager
    
    init(coordinator: Coordinator, user: UserModel) {
        self.coordinator = coordinator
        self.dataManager = DataManager()
        self.user = user
    }
    
    func getName() -> String {
        let name = user.name
        return String(format: "%@ %@", name.first, name.last)
    }
    
    func getLocation() -> String {
        let location = user.location
        return String(format: "%@, %@", location.city, location.street)
    }
    
    func getAvatarPath() -> String {
        return user.picture.large
    }
    
    func getMail() -> String {
        return user.email
    }
    
    func getPhone() -> String {
        return user.phone
    }
}

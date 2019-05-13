//
//  MainListViewModel.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import Foundation

enum AppearType {
    case list, grid
}

enum SortType {
    case firstName, lastName
}

protocol MainListViewModelProtocol {
    var usersHandler: ((_ indexPaths: [IndexPath]) -> Void)? { get set }
    var users: [UserModel] { get }
    var type: AppearType { get }
    var sortHandler: (() -> Void)? { get set }
    
    func usersCount() -> Int
    func getUser(for indexPath: IndexPath) -> UserModel
    func getUsers()
    func refreshed()
    func showProfile(for indexPath: IndexPath)
    func sort(type: SortType)
}

class MainListViewModel: MainListViewModelProtocol, BaseViewModel {
    
    private var page: Int = 0
    private var limit: Int = 50
    private var isUpdating: Bool = false
    
    var coordinator: Coordinator
    var dataManager: DataManager
    var usersHandler: ((_ indexPaths: [IndexPath]) -> Void)? {
        didSet { getUsers() }
    }
    var sortHandler: (() -> Void)?
    var users: [UserModel] = []
    var type: AppearType
    
    init(coordinator: Coordinator, type: AppearType = .list) {
        self.coordinator = coordinator
        self.dataManager = DataManager()
        self.type = type
    }
    
    private func sortByFirstName() {
        users.sort { left, right -> Bool in
            left.name.first < right.name.first
        }
        sortHandler?()
    }
    
    private func sortByLastName() {
        users.sort { left, right -> Bool in
            left.name.last < right.name.last
        }
        sortHandler?()
    }
    
    func getUsers() {
        if isUpdating { return }
        isUpdating = true
        dataManager.getUsers(page: page, limit: limit) { [weak self] users, error in
            guard let users = users else {
                NSLog("Error when getting user's: %@", error ?? "")
                return
            }
            var lastIndex = (self?.users.count ?? 0)
            var indexPaths = [IndexPath]()
            users.forEach { _ in
                indexPaths.append(IndexPath(row: lastIndex, section: 0))
                lastIndex += 1
            }
            self?.users.append(contentsOf: users)
            self?.usersHandler?(indexPaths)
            self?.page += 1
        }
    }
    
    func usersCount() -> Int {
        return users.count
    }
    
    func getUser(for indexPath: IndexPath) -> UserModel {
        return users[indexPath.row]
    }
    
    func showProfile(for indexPath: IndexPath) {
        let user = users[indexPath.row]
        coordinator.showProfile(user: user)
    }
    
    func sort(type: SortType) {
        switch type {
        case .firstName:
            sortByFirstName()
        case .lastName:
            sortByLastName()
        }
    }
    
    func refreshed() {
        isUpdating = false
    }
}

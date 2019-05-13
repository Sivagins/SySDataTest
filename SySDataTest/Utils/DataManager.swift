//
//  DataManager.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import Foundation

class DataManager: NSObject {
    
    var network: NetworkService
    
    override init() {
        self.network = NetworkService()
        super.init()
    }
    
    func getUsers(completion: @escaping CompletionBlock<[UserModel]>) {
        network.getUsers(offset: 100) { response, error in
            completion(response?.results, error)
        }
    }
    
    func getUsers(page: Int, limit: Int, completion: @escaping CompletionBlock<[UserModel]>) {
        network.getUsers(page: page, limit: limit) { response, error in
            completion(response?.results, error)
        }
    }
}

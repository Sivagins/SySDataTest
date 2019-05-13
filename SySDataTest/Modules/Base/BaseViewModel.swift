//
//  BaseViewModel.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import Foundation

protocol BaseViewModel {
    var coordinator: Coordinator { get set }
    var dataManager: DataManager { get set }
}

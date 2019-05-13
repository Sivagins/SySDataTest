//
//  MainPickerViewController.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import UIKit

class MainPickerViewController: BaseViewController {
    
    var viewModel: MainPickerViewModelProtocol
    
    init(viewModel: MainPickerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: MainPickerViewController.className, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Picker"
        super.viewWillAppear(animated)
    }
    
    @IBAction func onTableTapped(_ sender: Any) {
        viewModel.showList()
    }
    
    @IBAction func onCollectionTapped(_ sender: Any) {
        viewModel.showCollection()
    }
}

//
//  MainListViewController.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import UIKit

class MainListViewController: BaseViewController {

    private var tableView: UITableView?
    private var collectionView: UICollectionView?
    
    var viewModel: MainListViewModelProtocol
    
    init(viewModel: MainListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: MainListViewController.className, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        if viewModel.type == .grid {
            setupCollectionView()
        } else {
            setupTableView()
        }
        setupUsersHandler()
        setupSortHandler()
    }
    
    private func setupNavigationBar() {
        let sortBarItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(onSortTapped))
        navigationItem.rightBarButtonItem = sortBarItem
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorColor = UIColor.gray
        tableView?.separatorInset = UIEdgeInsets.zero
        tableView?.backgroundColor = .white
        // register cell
        let name = MainListUserTableViewCell.className
        tableView?.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
        if let tableView = tableView {
            view.addSubview(tableView)
            setParentConstranits(for: tableView)
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .white
        let name = MainListUserCollectionViewCell.className
        collectionView?.register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
        if let collectionView = collectionView {
            view.addSubview(collectionView)
            setParentConstranits(for: collectionView)
        }
    }
    
    private func setParentConstranits(for targetView: UIView) {
        targetView.translatesAutoresizingMaskIntoConstraints = false
        targetView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        targetView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        targetView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        targetView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
    }
    
    private func setupUsersHandler() {
        showLoading()
        viewModel.usersHandler = { [weak self] indexPaths in
            self?.hideLoading()
            self?.tableView?.insertRows(at: indexPaths, with: .none)
            self?.collectionView?.insertItems(at: indexPaths)
            self?.viewModel.refreshed()
        }
    }
    
    private func setupSortHandler() {
        viewModel.sortHandler = { [weak self] in
            self?.tableView?.reloadData()
            self?.collectionView?.reloadData()
        }
    }
    
    @objc func onSortTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let sortByFirstAction = UIAlertAction(title: "Sort by first name", style: .default) { [unowned self] _ in
            self.viewModel.sort(type: .firstName)
        }
        let sortByLastAction = UIAlertAction(title: "Sort by last name", style: .default) { [unowned self] _ in
            self.viewModel.sort(type: .lastName)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(sortByFirstAction)
        alert.addAction(sortByLastAction)
        alert.addAction(cancelAction)
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = view
            popoverController.sourceRect = view.bounds
            popoverController.permittedArrowDirections = []
        }
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate

extension MainListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showProfile(for: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MainListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.usersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainListUserTableViewCell.className, for: indexPath)
        if let cell = cell as? MainListUserTableViewCell {
            let user = viewModel.getUser(for: indexPath)
            cell.setup(with: user)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom * 0.5 < height {
            viewModel.getUsers()
        }
    }
}

// MARK: - UICollectionViewDelegate

extension MainListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showProfile(for: indexPath)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: 140)
    }
}

// MARK: - UICollectionViewDataSource

extension MainListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.usersCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainListUserCollectionViewCell.className, for: indexPath)
        if let cell = cell as? MainListUserCollectionViewCell {
            let user = viewModel.getUser(for: indexPath)
            cell.setup(with: user)
        }
        return cell
    }
}

//
//  GroupsTableViewController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 11.09.2023.
//

import UIKit

final class GroupsTableViewController: UITableViewController {
    
    private let networkService = NetworkService()
    private let dataManager = DataManager()
    
    private var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppearance()
        
        tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.reuseIdentifier)

        groups = dataManager.fetchGroups()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(getGroups), for: .valueChanged)
        tableView.reloadData()

        getGroups()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: GroupsTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? GroupsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(group: groups[indexPath.row])
        return cell
    }
    
    @objc func getGroups() {
        showIndicator()
        networkService.getGroups { [weak self] result in
            switch result {
            case .success(let groups):
                self?.groups = groups
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.hideIndicator()
                }
            case .failure(_):
                self?.groups = self?.dataManager.fetchGroups() ?? []
                DispatchQueue.main.async {
                    self?.hideIndicator()
                    self?.showAlert()
                }
            }
            DispatchQueue.main.async {
                self?.refreshControl?.endRefreshing()
            }
        }
    }

    func showAlert() {
        var message: String?
        if let formattedDate = dataManager.fetchGroupDate()?.getDateString(with: .ru) {
            message = "last updated was \(String(describing: formattedDate))"
        } else {
            message = nil
        }
        let alert = UIAlertController(
            title: "Data received data",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

private extension GroupsTableViewController {
    func configureAppearance() {
        title = Strings.TabBar.title(for: .groups)
        tableView.backgroundColor = .mainBackground
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
}

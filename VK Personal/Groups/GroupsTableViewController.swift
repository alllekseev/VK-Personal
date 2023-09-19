//
//  GroupsTableViewController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 11.09.2023.
//

import UIKit

final class GroupsTableViewController: UITableViewController {

    private let networkService = NetworkService()

    private var groups = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAppearance()
        
        tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.reuseIdentifier)

        showIndicator()

        networkService.getGroups { [weak self] groups in
            self?.groups = groups
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.hideIndicator()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.reuseIdentifier, for: indexPath) as? GroupsTableViewCell else {
            return UITableViewCell()
        }

        cell.configureCell(group: groups[indexPath.row])
        return cell
    }
}

private extension GroupsTableViewController {
    func configureAppearance() {
        title = Strings.TabBar.title(for: .groups)
        tableView.backgroundColor = Colors.background
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
}

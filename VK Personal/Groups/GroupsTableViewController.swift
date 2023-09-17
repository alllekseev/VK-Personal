//
//  GroupsTableViewController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 11.09.2023.
//

import UIKit

final class GroupsTableViewController: UITableViewController {

    private let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.reuseIdentifier)

        configureAppearance()

        networkService.fetchGroups(quantity: 5)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.reuseIdentifier, for: indexPath) as? GroupsTableViewCell else {
            return UITableViewCell()
        }

        cell.configureCell(name: "Group \(indexPath.row + 1)", description: "Description")
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

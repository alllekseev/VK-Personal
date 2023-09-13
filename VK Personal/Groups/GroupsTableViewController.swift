//
//  GroupsTableViewController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 11.09.2023.
//

import UIKit

final class GroupsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.reuseIdentifier)

        configureAppearance()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
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
        tableView.backgroundColor = Colors.mainBackground
    }
}

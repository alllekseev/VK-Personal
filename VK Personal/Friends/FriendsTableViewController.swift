//
//  FriendsTableViewController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 11.09.2023.
//

import UIKit

final class FriendsTableViewController: UITableViewController {

    private let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            FriendsTableViewCell.self,
            forCellReuseIdentifier: FriendsTableViewCell.reuseIdentifier)

        configureAppearance()

//        networkService.fetchFriends(quantity: 5)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseIdentifier) as? FriendsTableViewCell else { return UITableViewCell()
        }

        cell.configureCell(name: "Dan")
        return cell
    }

}

private extension FriendsTableViewController {

    func configureAppearance() {
        title = Strings.TabBar.title(for: .friends)
        view.backgroundColor = Colors.background
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
}

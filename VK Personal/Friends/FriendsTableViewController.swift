//
//  FriendsTableViewController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 11.09.2023.
//

import UIKit

final class FriendsTableViewController: UITableViewController {

    private let networkService = NetworkService()

    private var friends = [Friend]()

    private lazy var profileNavButton = ProfileNavButton(frame: view.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAppearance()

        tableView.register(FriendsTableViewCell.self,
                           forCellReuseIdentifier: FriendsTableViewCell.reuseIdentifier)

        showIndicator()

        networkService.getFriends { [weak self] friends in
            self?.friends = friends
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.hideIndicator()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseIdentifier) as? FriendsTableViewCell else { return UITableViewCell()
        }

        cell.configureCell(friend: friends[indexPath.row])
        return cell
    }

}

private extension FriendsTableViewController {
    func configureAppearance() {
        title = Strings.TabBar.title(for: .friends)
        view.backgroundColor = Colors.background
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        profileNavButton.addTarget(self, action: #selector(tappedNavigateToProfile), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileNavButton)
    }
}

@objc private extension FriendsTableViewController {
    func tappedNavigateToProfile() {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.type = .fade
        animation.duration = 1.5
        navigationController?.view.layer.add(animation, forKey: nil)
        navigationController?.pushViewController(ProfileViewController(), animated: false)
    }
}

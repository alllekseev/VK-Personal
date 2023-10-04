//
//  FriendsTableViewController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 11.09.2023.
//

import UIKit

final class FriendsTableViewController: UITableViewController {

    private let networkService = NetworkService()
    private let dataManager = DataManager()

    private var friends = [Friend]()

    private lazy var profileNavButton = ProfileNavButton(frame: view.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAppearance()

        tableView.register(FriendsTableViewCell.self,
                           forCellReuseIdentifier: FriendsTableViewCell.reuseIdentifier)

        friends = dataManager.fetchFriends()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(getFriends), for: .valueChanged)
        tableView.reloadData()
        getFriends()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FriendsTableViewCell.reuseIdentifier
        ) as? FriendsTableViewCell else { return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configureCell(friend: friends[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = friends[indexPath.row]
        let account = Account(name: friend.name,
                              surname: friend.surname,
                              photoUrl: friend.photoUrl,
                              photoData: friend.photoData)

        let profileViewController = ProfileViewController()
        profileViewController.getAccount(isUserProfile: false, account: account)

        navigationController?.pushViewController(profileViewController, animated: true)
    }

    @objc func getFriends() {
        showIndicator()
        networkService.getFriends { [weak self] result in
            switch result {
            case .success(let friends):
                self?.friends = friends
                self?.dataManager.addFriends(friends: friends)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.hideIndicator()
                }
            case .failure(_):
                self?.friends = self?.dataManager.fetchFriends() ?? []
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
        if let formattedDate = dataManager.fetchFriendDate()?.getDateString(with: .ru) {
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

private extension FriendsTableViewController {
    func configureAppearance() {
        title = Strings.TabBar.title(for: .friends)
        view.backgroundColor = .mainBackground
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        profileNavButton.addTarget(self, action: #selector(tappedNavigateToProfile), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileNavButton)
    }
}

@objc private extension FriendsTableViewController {
    func tappedNavigateToProfile() {
//        let animation = CATransition()
//        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
//        animation.type = .fade
//        animation.duration = 1.5
//        navigationController?.view.layer.add(animation, forKey: nil)
        let profileViewController = ProfileViewController()
        profileViewController.getAccount(isUserProfile: true)
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}

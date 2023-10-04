//
//  ProfileViewController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 19.09.2023.
//

import UIKit
// TODO: make init?
final class ProfileViewController: VKBaseController {

    private lazy var profileView = ProfileView(frame: view.bounds)

    private let themeButton = MenuButton()

    private let networkService = NetworkService()

    private var account: Account!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func getAccount(isUserProfile: Bool = true, account: Account? = nil) {
        showIndicator()

        if isUserProfile {
            networkService.getAccount { [weak self] result in
                switch result {
                case .success(let account):
                    self?.account = account
                    DispatchQueue.main.async {
                        self?.profileView.configure(account: account)
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.showAlert()
                    }
                }
            }
        } else {
            guard let account = account else {
                return
            }
            profileView.configure(account: account)
        }
        DispatchQueue.main.async {
            self.hideIndicator()
        }
    }

    func getFriendProfile(account: Account) {

    }

    func showAlert() {
        let alert = UIAlertController(title: "Network connection failure", message: "Return to the previous page?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        })
        present(alert, animated: true)
    }
}

extension ProfileViewController {
    override func addSubviews() {
        super.addSubviews()
        view.setupView(profileView)
    }

    override func setupLayout() {
        super.setupLayout()
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()
        title = "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: themeButton)
    }
}

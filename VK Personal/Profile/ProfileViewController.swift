//
//  ProfileViewController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 19.09.2023.
//

import UIKit

final class ProfileViewController: VKBaseController {

    private lazy var profileView = ProfileView(frame: view.bounds)

    private let themeButton = MenuButton()

    private let networkService = NetworkService()

    private var account: Account!

    override func viewDidLoad() {
        super.viewDidLoad()

        showIndicator()

        networkService.getAccount { [weak self] (account, error) in
            self?.account = account
            DispatchQueue.main.async {
                guard let account else {
                    self?.hideIndicator()
                    return
                }
                self?.profileView.configure(account: account)
                self?.hideIndicator()
            }
        }
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
        title = "Профиль"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: themeButton)
    }
}

#Preview {
    let vc = ProfileViewController()

    return vc
}

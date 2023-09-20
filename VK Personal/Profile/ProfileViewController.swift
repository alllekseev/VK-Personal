//
//  ProfileViewController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 19.09.2023.
//

import UIKit

final class ProfileViewController: VKBaseController {

    private lazy var profileView = ProfileView(frame: view.bounds)

    private let networkService = NetworkService()

    private var account: Account!

    override func viewDidLoad() {
        super.viewDidLoad()

        showIndicator()

        networkService.getAccount { [weak self] account in
            self?.account = account
            DispatchQueue.main.async {
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
    }
}

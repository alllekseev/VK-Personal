//
//  AuthViewController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 01.09.2023.
//

import UIKit

final class AuthViewController: VKBaseController {

    // MARK: - Private Properties
    private let authView = AuthView()
}

extension AuthViewController {
    override func addSubviews() {
        super.addSubviews()
        view.setupView(authView)
    }

    override func setupLayout() {
        super.setupLayout()

        NSLayoutConstraint.activate([
            authView.topAnchor.constraint(equalTo: view.topAnchor),
            authView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            authView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            authView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    // use delegate when open keyboard
}

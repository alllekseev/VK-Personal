//
//  NavBarController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 11.09.2023.
//

import UIKit

final class NavBarController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    private func configure() {
        view.backgroundColor = .white
        navigationBar.isTranslucent = false
        navigationBar.standardAppearance.titleTextAttributes = [
            .foregroundColor: Colors.main,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]

        navigationBar.addBottomBorder(with: Colors.textPlaceholder, height: 1)
    }
}

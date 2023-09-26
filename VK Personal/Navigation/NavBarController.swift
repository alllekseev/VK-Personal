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
        view.backgroundColor = .mainBackground
        navigationBar.isTranslucent = true
        navigationBar.prefersLargeTitles = true
    }
}

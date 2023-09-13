//
//  BigButton.swift
//  VK Personal
//
//  Created by Олег Алексеев on 02.09.2023.
//

import UIKit

final class BigButton: UIButton {
    init(title: String, height: CGFloat) {
        super.init(frame: .zero)
        setupButton(title: title, height: height)

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton(title: String, height: CGFloat) {

//        backgroundColor = Colors.main
        layer.backgroundColor = Colors.main.cgColor
        layer.cornerRadius = 24

        setTitle(title, for: .normal)
        titleLabel?.textColor = Colors.white
        titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}

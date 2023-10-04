//
//  ProfileNavButton.swift
//  VK Personal
//
//  Created by Олег Алексеев on 19.09.2023.
//

import UIKit

final class ProfileNavButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 140, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "person.crop.circle", withConfiguration: symbolConfiguration)
        setImage(image, for: .normal)
        tintColor = .main
        backgroundColor = .clear
        layer.cornerRadius = 16

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 32),
            widthAnchor.constraint(equalTo: heightAnchor),
        ])
    }
}

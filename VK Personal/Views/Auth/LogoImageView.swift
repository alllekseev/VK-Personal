//
//  LogoImageView.swift
//  VK Personal
//
//  Created by Олег Алексеев on 02.09.2023.
//

import UIKit

final class LogoImageView: UIImageView {
    init(image: UIImage) {
        super.init(frame: .zero)

        setupLogo(with: image)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLogo(with image: UIImage) {
        self.image = image

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 80),
            widthAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}

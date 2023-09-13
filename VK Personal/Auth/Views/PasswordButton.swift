//
//  PasswordButton.swift
//  VK Personal
//
//  Created by Олег Алексеев on 07.09.2023.
//

import UIKit

final class PasswordButton: UIButton {

    enum PasswordButtons {
        case show
        case hide

        var image: UIImage {
            switch self {
            case .show:
                return Icons.passwordShow ?? UIImage()
            case .hide:
                return Icons.passwordHide ?? UIImage()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func configure() {
        setImage(PasswordButtons.hide.image, for: .normal)
        isEnabled = false

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 30),
            heightAnchor.constraint(equalTo: widthAnchor),
        ])
    }

}

//
//  AuthTextField.swift
//  VK Personal
//
//  Created by Олег Алексеев on 01.09.2023.
//

import UIKit

final class AuthTextField: UITextField {
    // MARK: - Private Properties
    private let padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 14)

    // MARK: - Initializers
    init(placeholder: String) {
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    // MARK: - Private Methods
    private func setupTextField(placeholder: String) {
        textColor = .black
        layer.cornerRadius = 16
        backgroundColor = Colors.white
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor : Colors.textPlaceholder!
            ]
        )
        font = .systemFont(ofSize: 16)
        heightAnchor.constraint(equalToConstant: 54).isActive = true
    }
}

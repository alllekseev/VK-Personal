//
//  AuthTextField.swift
//  VK Personal
//
//  Created by Олег Алексеев on 01.09.2023.
//

import UIKit

class AuthTextField: UITextField {
    // MARK: - Private Properties
    private let padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 50)

    // MARK: - Initializers
    init(placeholder: String, frame: CGRect) {
        super.init(frame: frame)
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

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.maxX - 46, y: 12, width: 30, height: 30)
    }

    // MARK: - Private Methods
    func setupTextField(placeholder: String) {
        textColor = .black
        layer.cornerRadius = 16
        backgroundColor = Colors.clearWhite

        // FIXME: - fix shadow
        layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: bounds.width, height: 54), cornerRadius: 0).cgPath
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 4)

        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor : Colors.textPlaceholder
            ]
        )
        font = .systemFont(ofSize: 16)
        heightAnchor.constraint(equalToConstant: 54).isActive = true
    }
}

//
//  AuthTextField.swift
//  VK Personal
//
//  Created by Олег Алексеев on 01.09.2023.
//

import UIKit

class AuthTextField: UITextField {
    // MARK: - Private Properties
    private let padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 16)

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
    func setupTextField(placeholder: String) {
        textColor = .black
        layer.cornerRadius = 16
        backgroundColor = Colors.white

        // FIXME: - fix shadow
        layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), cornerRadius: 0).cgPath
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 4)

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

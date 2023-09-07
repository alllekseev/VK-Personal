//
//  PasswordTextField.swift
//  VK Personal
//
//  Created by Олег Алексеев on 07.09.2023.
//

import UIKit

final class PasswordTextField: AuthTextField {
    private let passwordButton = PasswordButton()

    private var isPrivate = true

    override init(placeholder: String) {
        super.init(placeholder: placeholder)

        configureView()
    }
}

private extension PasswordTextField {
    func configureView() {

        isSecureTextEntry = true
        delegate = self
        rightView = passwordButton
        rightViewMode = .always

        addActions()
    }

    func addActions() {
        passwordButton.addTarget(
            self,
            action: #selector(displayPassword),
            for: .touchUpInside)
    }
}

@objc private extension PasswordTextField {
    func displayPassword() {
        let image = isPrivate ?
        PasswordButton.PasswordButtons.show.image :
        PasswordButton.PasswordButtons.hide.image

        isSecureTextEntry.toggle()
        passwordButton.setImage(image, for: .normal)
        isPrivate.toggle()
    }
}

extension PasswordTextField: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        passwordButton.isEnabled = !text.isEmpty
    }
}

//
//  AuthView.swift
//  VK Personal
//
//  Created by Олег Алексеев on 02.09.2023.
//

import UIKit

protocol AuthViewDelegate: AnyObject {
    func tappedLogin(_ vc: UIViewController)
}

final class AuthView: VKBaseView {

    weak var delegate: AuthViewDelegate?

    private lazy var loginTextField = AuthTextField(placeholder: "Логин", frame: frame)
    private lazy var passwordTextField = PasswordTextField(placeholder: "Пароль", frame: frame)
    private let logoImageView = LogoImageView(image: Icons.logo!)
    private let titleLabel = TitleLabel(text: "Авторизация")
    private let loginButton = BigButton(title: "Войти", height: 64)

    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 58
        return stackView
    }()

    private let textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 24
        return stackView
    }()

    func configure(login: String, password: String) {
        loginTextField.text = login
        passwordTextField.text = password
    }
}

extension AuthView {
    override func configureView() {
        super.configureView()
        addActions()

        loginTextField.keyboardType = .emailAddress
        loginTextField.returnKeyType = .next

        loginTextField.delegate = self
//        passwordTextField.delegate = self
    }
    
    override func addSubviews() {
        super.addSubviews()

        mainStackView.addArrangedSubview(logoImageView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(textFieldStackView)

        textFieldStackView.addArrangedSubview(loginTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)


        setupView(textFieldStackView)
        setupView(mainStackView)
        setupView(loginButton)
    }

    override func setupLayout() {
        super.setupLayout()

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 83),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            textFieldStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 54),
            textFieldStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            textFieldStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),

            loginTextField.leadingAnchor.constraint(equalTo: textFieldStackView.leadingAnchor),
            loginTextField.trailingAnchor.constraint(equalTo: textFieldStackView.trailingAnchor),

            passwordTextField.leadingAnchor.constraint(equalTo: textFieldStackView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: textFieldStackView.trailingAnchor),


            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            loginButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -64),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()

        backgroundColor = Colors.mainBackground
    }

    func addActions() {
        loginButton.addTarget(nil, action: #selector(tappedLogin), for: .touchUpInside)
    }
}


extension AuthView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        passwordTextField.becomeFirstResponder()

        return true
    }
}

@objc extension AuthView {
    func tappedLogin() {
        self.delegate?.tappedLogin(TabBarController())
    }
}

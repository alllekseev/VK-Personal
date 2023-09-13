//
//  AuthViewController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 01.09.2023.
//

import UIKit

final class AuthViewController: VKBaseController {

    // MARK: - Private Properties
    private let authView = AuthView()
    private let scrollView = UIScrollView()

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()

        registerForKeyboardNotifications()
    }

    // MARK: - deinit
    deinit {
        removeKeyboardNotifications()
    }

    // MARK: - Private Methods
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil)

        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
}

extension AuthViewController {
    override func addSubviews() {
        super.addSubviews()

        view.setupView(scrollView)

        scrollView.setupView(authView)
    }

    override func setupLayout() {
        super.setupLayout()

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            authView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            authView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            authView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            authView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            authView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()
        scrollView.backgroundColor = Colors.mainBackground
    }
}

@objc private extension AuthViewController {
    func keyboardWillShow(_ notification: NSNotification) {
        let userInfo = notification.userInfo
        if let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue) {
            let keyboardFrameSize = keyboardFrame.cgRectValue
            scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrameSize.height)
        }
    }

    func keyboardWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
}

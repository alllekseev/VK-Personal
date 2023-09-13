//
//  AuthViewController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 01.09.2023.
//

import UIKit

final class AuthViewController: VKBaseController {

    // MARK: - Private Properties
    private lazy var authView = AuthView(frame: view.bounds)

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        authView.delegate = self

        self.hideKeyboardWhenTappedAround()

//        registerForKeyboardNotifications()
    }

    // MARK: - deinit
//    deinit {
//        removeKeyboardNotifications()
//    }

    // MARK: - Private Methods
//    private func registerForKeyboardNotifications() {
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(keyboardWillShow),
//            name: UIResponder.keyboardWillShowNotification,
//            object: nil)
//
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(keyboardWillHide),
//            name: UIResponder.keyboardWillHideNotification,
//            object: nil)
//    }

//    private func removeKeyboardNotifications() {
//        NotificationCenter.default.removeObserver(
//            self,
//            name: UIResponder.keyboardWillShowNotification,
//            object: nil)
//
//        NotificationCenter.default.removeObserver(
//            self,
//            name: UIResponder.keyboardWillHideNotification,
//            object: nil)
//    }
}

extension AuthViewController {
    override func addSubviews() {
        super.addSubviews()

        view.setupView(authView)
    }

    override func setupLayout() {
        super.setupLayout()

        NSLayoutConstraint.activate([
            authView.topAnchor.constraint(equalTo: view.topAnchor),
            authView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            authView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            authView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            authView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

//    override func configureAppearance() {
//        super.configureAppearance()
//        view.backgroundColor = Colors.mainBackground
//    }
}

//@objc private extension AuthViewController {
//    func keyboardWillShow(_ notification: NSNotification) {
//        let userInfo = notification.userInfo
//        if let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue) {
//            let keyboardFrameSize = keyboardFrame.cgRectValue
//            scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrameSize.height)
//        }
//    }
//
//    func keyboardWillHide() {
//        scrollView.contentOffset = CGPoint.zero
//    }
//}

extension AuthViewController: AuthViewDelegate {
    func tappedLogin(_ vc: UIViewController) {

//        navigationController?.pushViewController(vc, animated: true)

        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let firstWindow = firstScene.windows.first else { return }

        firstWindow.rootViewController = vc
    }
}

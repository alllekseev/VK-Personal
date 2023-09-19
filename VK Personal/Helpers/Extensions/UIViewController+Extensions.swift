//
//  UIViewController+.swift
//  VK Personal
//
//  Created by Олег Алексеев on 07.09.2023.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    static let loadingIndicator = UIActivityIndicatorView(style: .medium)

    func showIndicator() {
        let loadingIndicator = UIViewController.loadingIndicator

        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        loadingIndicator.startAnimating()
    }

    func hideIndicator() {
        let loadingIndicator = UIViewController.loadingIndicator
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }
}

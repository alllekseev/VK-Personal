//
//  UIView+.swift
//  VK Personal
//
//  Created by Олег Алексеев on 02.09.2023.
//

import UIKit

extension UIView {
    func setupView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }

    func debugFrame(_ view: UIView, with color: UIColor = .red) {
        view.layer.borderWidth = 1
        view.layer.borderColor = color.cgColor
    }
}

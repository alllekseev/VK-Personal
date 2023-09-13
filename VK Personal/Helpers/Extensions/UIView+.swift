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

    func debugOutline(with color: UIColor = .red) {
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
    }
}

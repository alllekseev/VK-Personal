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

    func addBottomBorder(with color: UIColor, height: CGFloat) {
        let separator = UIView()
        separator.backgroundColor = color
        separator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        separator.frame = CGRect(x: 0,
                                 y: frame.height - height,
                                 width: frame.width,
                                 height: height)
        
        addSubview(separator)
    }
}

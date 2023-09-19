//
//  PhotoView.swift
//  VK Personal
//
//  Created by Олег Алексеев on 13.09.2023.
//

import UIKit

final class PhotoView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = Colors.textPlaceholder
        layer.cornerRadius = 30
        layer.masksToBounds = true

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60),
            widthAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}

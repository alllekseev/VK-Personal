//
//  OnlineIndicatorView.swift
//  VK Personal
//
//  Created by Олег Алексеев on 19.09.2023.
//

import UIKit

enum OnlineStatus: Int, Decodable {
    case offline = 0
    case online = 1
}

final class OnlineIndicatorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        layer.cornerRadius = 8
        layer.borderWidth = 2
        layer.borderColor = UIColor.element.cgColor

        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 16),
            widthAnchor.constraint(equalTo: heightAnchor),
        ])
    }
}

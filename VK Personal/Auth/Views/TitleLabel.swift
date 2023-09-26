//
//  TitleLabel.swift
//  VK Personal
//
//  Created by Олег Алексеев on 02.09.2023.
//

import UIKit

final class TitleLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        setupLabel(with: text)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLabel(with text: String) {
        self.text = text

        font = .systemFont(ofSize: 22, weight: .bold)
        textColor = .main
        textAlignment = .center
    }
}

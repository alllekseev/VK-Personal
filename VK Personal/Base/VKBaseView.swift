//
//  VKBaseView.swift
//  VK Personal
//
//  Created by Олег Алексеев on 01.09.2023.
//

import UIKit

class VKBaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc extension VKBaseView: BaseViewProtocol {
    func configureView() {
        addSubviews()
        setupLayout()
        configureAppearance()
    }
    
    func addSubviews() { }

    func setupLayout() { }

    func configureAppearance() { }
}

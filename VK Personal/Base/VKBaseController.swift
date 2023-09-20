//
//  VKBaseController.swift
//  VK Personal
//
//  Created by Олег Алексеев on 01.09.2023.
//

import UIKit

class VKBaseController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

@objc extension VKBaseController: BaseViewProtocol {
    func configureView() {
        addSubviews()
        setupLayout()
        configureAppearance()
    }
    
    func addSubviews() { }
    func setupLayout() { }
    func configureAppearance() {
        view.backgroundColor = Colors.background
    }
}

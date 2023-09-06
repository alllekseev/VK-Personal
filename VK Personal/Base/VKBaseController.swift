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
    func addSubviews() {
        print("1")
    }
    func setupLayout() { }
    func configureAppearance() {
        view.backgroundColor = .lightGray
    }
}

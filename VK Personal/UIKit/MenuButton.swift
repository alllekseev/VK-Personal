//
//  MenuButton.swift
//  VK Personal
//
//  Created by Олег Алексеев on 25.09.2023.
//

import UIKit

final class MenuButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func configure() {
        setTitle("Change Theme", for: .normal)
        setTitleColor(.element, for: .normal)
        layer.cornerRadius = 8
        backgroundColor = .textSecondary
        menu = getMenu()
        showsMenuAsPrimaryAction = true
    }

    private func getMenu() -> UIMenu {
        .init(title: "Theme",
              children: [
                UIAction(title: "Default", state: .on) { _ in
                    print("Default")
                },
                UIAction(title: "Light", state: .off) { _ in
                    print("Light")
                },
                UIAction(title: "Dark", state: .off) { _ in
                    print("Dark")
                },
              ]
        )
    }
}

//
//  Icons.swift
//  VK Personal
//
//  Created by Олег Алексеев on 02.09.2023.
//

import UIKit

enum Icons {
    static let logo = UIImage(named: "logo")
    static let passwordHide = UIImage(named: "passwordHide")
    static let passwordShow = UIImage(named: "passwordShow")

    enum TabBarIcons {
        static func icon(for tab: Tabs) -> UIImage? {
            switch tab {
            case .friends: return UIImage(systemName: "person.2")
            case .groups: return UIImage(systemName: "rectangle.stack.badge.person.crop")
            case .photos: return UIImage(systemName: "photo.on.rectangle")
            }
        }
    }
}

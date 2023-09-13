//
//  Strings.swift
//  VK Personal
//
//  Created by Олег Алексеев on 11.09.2023.
//

import Foundation


enum Strings {
    enum TabBar {
        static func title(for tab: Tabs) -> String {
            switch tab {
            case .friends: return "Friends"
            case .groups: return "Groups"
            case .photos: return "Photos"
            }
        }
    }
}

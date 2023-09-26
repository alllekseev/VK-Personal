//
//  Theme.swift
//  VK Personal
//
//  Created by Олег Алексеев on 24.09.2023.
//

import UIKit

enum Style {
    case light
    case dark
    case specific
}

protocol ThemeProtocol {
    var userInterfaceStyle: UIUserInterfaceStyle { get set }
}

struct Theme {
    static var currentTheme: ThemeProtocol = DefaultTheme()
}

class DefaultTheme: ThemeProtocol {
    var userInterfaceStyle: UIUserInterfaceStyle = .unspecified
}

class LightTheme: ThemeProtocol {
    var userInterfaceStyle: UIUserInterfaceStyle = .light
}

class DarkTheme: ThemeProtocol {
    var userInterfaceStyle: UIUserInterfaceStyle = .dark
}


// TODO: - make extension for UIColor and return different colors by one name

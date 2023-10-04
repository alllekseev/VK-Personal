//
//  ThemeProtocol.swift
//  VK Personal
//
//  Created by Олег Алексеев on 28.09.2023.
//

import UIKit

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

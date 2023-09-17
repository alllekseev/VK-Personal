//
//  ApiData.swift
//  VK Personal
//
//  Created by Олег Алексеев on 14.09.2023.
//

import Foundation

enum ApiData {
    static let authUrlString = "https://oauth.vk.com"
    static let blankUrlString = "https://oauth.vk.com/blank.html"
    static let blankHtml = "/blank.html"

    static let baseUrlString = "https://api.vk.com/method"

    static var token = ""
    static var userID = ""

    enum MethodType {
        static let get = ".get"
    }

    enum Endpoints {
        static let authorize = "/authorize"
        static let friends = "/friends"
        static let groups = "/groups"
        static let photos = "/photos"
    }
}

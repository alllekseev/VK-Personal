//
//  ApiData.swift
//  VK Personal
//
//  Created by Олег Алексеев on 14.09.2023.
//

import Foundation

enum ApiData {
    static let authUrlString = "https://oauth.vk.com"
    static let authEndpoint = "/authorize"
    static let blankUrlString = "https://oauth.vk.com/blank.html"
    static let blankHtml = "/blank.html"

    static var token: String?
    static var userID: String?

    static let baseUrlString = "https://api.vk.com/method"

    enum Endpoints: String {
        case friends = "/friends"
        case groups = "/groups"
        case photos = "/photos"
        case account = "/account"
    }

    enum MethodType: String {
        case get = ".get"
        case getProfileInfo = ".getProfileInfo"
    }
}

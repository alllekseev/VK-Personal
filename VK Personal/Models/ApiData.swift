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

    static var token: String? = "vk1.a.JkDEAItPSz8tPsrdLo-qwJ7f2jHyiDqeFIMutzAwzU2QbkMlJVythTnG6G7cVEQH1BPppAL3hqDoJesqW6bDNvUIAQUExjt4LwwaMzPLPSAexxRfm4UhPSmBXcWOtxicSihDmyOD_D1WcX7e8YK8uB_7g9hxBNJ1i9A3W7jiPMoIW6wWXtoUw_VLRYMnGNp4pNGv2DgkdK3Ckiw7TD1xyA"
    static var userID: String? = "102668466"

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

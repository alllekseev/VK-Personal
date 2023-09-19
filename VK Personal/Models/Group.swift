//
//  Group.swift
//  VK Personal
//
//  Created by Олег Алексеев on 15.09.2023.
//

import Foundation

struct Group: Decodable {
    let address: String
    let photoUrl: URL
    var photoData: Data?
    let name: String?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case address = "screen_name"
        case photoUrl = "photo_50"
        case photoData
        case name
        case description
    }
}

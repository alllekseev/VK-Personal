//
//  Group.swift
//  VK Personal
//
//  Created by Олег Алексеев on 15.09.2023.
//

import Foundation

struct Group: Decodable {
    let address: String
    let photo: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case address = "screen_name"
        case photo = "photo_50"
        case name
    }
}

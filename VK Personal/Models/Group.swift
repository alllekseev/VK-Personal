//
//  Group.swift
//  VK Personal
//
//  Created by Олег Алексеев on 15.09.2023.
//

import Foundation

struct Group: Decodable {
    let id: Int
    let photoUrl: URL?
    var photoData: Data?
    let name: String?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id
        case photoUrl = "photo_100"
        case photoData
        case name
        case description
    }
}

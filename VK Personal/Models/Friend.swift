//
//  Friends.swift
//  VK Personal
//
//  Created by Олег Алексеев on 14.09.2023.
//

import Foundation

struct Friend: Decodable {
    var id: Int
    var photo: String?
    var name: String?
    var surname: String?

    enum CodingKeys: String, CodingKey {
        case id
        case photo = "photo_50"
        case name = "first_name"
        case surname = "last_name"
    }
}

//
//  Friends.swift
//  VK Personal
//
//  Created by Олег Алексеев on 14.09.2023.
//

import UIKit

struct Friend: Decodable {
    let id: Int
    let photoUrl: URL?
    var photoData: Data?
    var name: String?
    var surname: String?
    let online: OnlineStatus

    enum CodingKeys: String, CodingKey {
        case id
        case photoUrl = "photo_50"
        case photoData
        case name = "first_name"
        case surname = "last_name"
        case online
    }
}

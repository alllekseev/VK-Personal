//
//  Friends.swift
//  VK Personal
//
//  Created by Олег Алексеев on 14.09.2023.
//

import UIKit

struct Friend: Decodable {
    let id: Int
    let online: OnlineStatus
    let photoUrl: URL?
    var photoData: Data?
    var name: String?
    var surname: String?



    enum CodingKeys: String, CodingKey {
        case id
        case photoUrl = "photo_100"
        case photoData
        case name = "first_name"
        case surname = "last_name"
        case online
    }

    static let friends: [Friend] = [
        .init(id: 1, online: .online, photoUrl: nil, name: "Test", surname: "User")
    ]
}

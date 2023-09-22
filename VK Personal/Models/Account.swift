//
//  Account.swift
//  VK Personal
//
//  Created by Олег Алексеев on 20.09.2023.
//

import Foundation

struct Account: Decodable {
    let name: String?
    let surname: String?
    let photoUrl: URL?
    var photoData: Data?

    enum CodingKeys: String, CodingKey {
        case name = "first_name"
        case surname = "last_name"
        case photoUrl = "photo_200"
        case photoData
    }

    var fullName: String {
        "\(name ?? "") \(surname ?? "")"
    }
}

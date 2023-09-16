//
//  Photo.swift
//  VK Personal
//
//  Created by Олег Алексеев on 14.09.2023.
//

import Foundation

struct Photo: Decodable {
    let id: Int
    let sizes: [PhotoSize]
}

struct PhotoSize: Decodable {
    let url: String
    let height: Int
    let width: Int
}

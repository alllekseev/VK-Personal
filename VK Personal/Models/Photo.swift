//
//  Photo.swift
//  VK Personal
//
//  Created by Олег Алексеев on 14.09.2023.
//

import Foundation

struct Photo: Decodable {
    let id: Int
    var sizes: [PhotoSize]
}

struct PhotoSize: Decodable {
    let url: URL
    let height: Int
    let width: Int
    var photoData: Data?
    let type: String
}

enum PhotoType: String {
    case s
    case m
    case x
}

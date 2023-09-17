//
//  ResponseWrapper.swift
//  VK Personal
//
//  Created by Олег Алексеев on 14.09.2023.
//

import Foundation

struct ResponseWrapper<T: Decodable>: Decodable {
    var response: Response<T>
}

struct Response<T: Decodable>: Decodable {
    var items: [T]
}

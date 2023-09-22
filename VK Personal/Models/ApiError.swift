//
//  ApiError.swift
//  VK Personal
//
//  Created by Олег Алексеев on 21.09.2023.
//

import Foundation

struct ApiErrorModel: Decodable {
    let error: ApiError
}

struct ApiError: Decodable {
    let code: ErrorCode

    enum CodingKeys: String, CodingKey {
        case code = "error_code"
    }
}

enum ErrorCode: Int, Decodable {
    case accessTokenHasExpired = 5
}

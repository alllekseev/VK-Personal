//
//  Data+Extensions.swift
//  VK Personal
//
//  Created by Олег Алексеев on 15.09.2023.
//

import Foundation

extension Data {

    func prettyPrintedJSONString() {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self,
                                                                 options: []),
              let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject,
                                                         options: [.prettyPrinted]),
              let prettyJSONString = String(data: jsonData, encoding: .utf8) else {
            return
        }
        print(prettyJSONString)
    }
}

//
//  Date+Extensions.swift
//  VK Personal
//
//  Created by Олег Алексеев on 27.09.2023.
//

import Foundation

extension Date {
    enum CustomLocale: String {
        case ru = "ru_RU"
    }
    func getDateString(with locale: CustomLocale) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: locale.rawValue)
        dateFormatter.dateStyle = .long

        return dateFormatter.string(from: self)
    }
}

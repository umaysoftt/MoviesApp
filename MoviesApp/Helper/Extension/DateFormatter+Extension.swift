//
//  DateFormatter+Extension.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation

extension DateFormatter {
    static func dateFormat(_ date: String?, format: String) -> String{
        guard let date = date else {
            return ""
        }
        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "en_US_POSIX")
        fmt.dateFormat = "yyyy-MM-dd"
        let dt = fmt.date(from: date)!
        fmt.dateFormat = format
        return fmt.string(from: dt)
    }
}

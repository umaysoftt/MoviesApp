//
//  String+Extension.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation

public extension String {
    static let empty = ""
    static let dot = "."
    static let comma = ","
    static let closeBracket = ")"
    static let openBracket = "("
    static let whiteSpace = " "
    static let zero = Int.zero.stringValue

    var isEmptyOrWhitespace: Bool {
        guard isEmpty else {
            return (trimmingCharacters(in: .whitespaces) == "")
        }
        return true
    }
}

//
//  Int+Extension.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

public extension Int {
    var stringValue: String {
        return String(self)
    }

    var floatValue: Float {
        Float(self)
    }

    var isZero: Bool {
        self == 0
    }

    var doubleValue: Double {
        Double(self)
    }

    var int64Value: Int64 {
        Int64(self)
    }

    func divide(to divider: Int) -> Int? {
        guard divider != 0 else { return nil }
        return self / divider
    }
}

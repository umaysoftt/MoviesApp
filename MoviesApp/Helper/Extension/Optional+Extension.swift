//
//  Optional+Extension.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

public extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        switch self {
        case let string?:
            return string.isEmpty
        case nil:
            return true
        }
    }

    var isNotNilOrEmpty: Bool {
        switch self {
        case let string?:
            return !string.isEmpty
        case nil:
            return false
        }
    }

    var isNotNilOrEmptyOrWhitespace: Bool {
        switch self {
        case let string?:
            return string.isEmptyOrWhitespace
        case nil:
            return false
        }
    }

    var orEmpty: String {
        self ?? ""
    }
}

public extension Optional {
    var isNotNil: Bool { self != nil }
    var isNil: Bool { self == nil }
}

public extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        switch self {
        case let collection?:
            return collection.isEmpty
        case nil:
            return true
        }
    }

    var isNotNilOrEmpty: Bool {
        switch self {
        case let collection?:
            return !collection.isEmpty
        case nil:
            return false
        }
    }
}

public extension Optional where Wrapped == Any {
    var isNotNil: Bool {
        self != nil
    }

    var isNil: Bool {
        self == nil
    }
}

public extension Optional where Wrapped == Int {
    var orZero: Int {
        self ?? 0
    }

    var isNilOrZero: Bool {
        self == nil || self == 0
    }

    var isNotNilNorZero: Bool {
        !isNilOrZero
    }
}

public extension Optional where Wrapped == Double {
    var orZero: Double {
        self ?? 0
    }

    var isNilOrZero: Bool {
        self == nil || self == 0
    }

    var isNotNilNorZero: Bool {
        !isNilOrZero
    }
}

public extension Optional where Wrapped == Bool {
    var orFalse: Bool {
        self ?? false
    }

    var orTrue: Bool {
        self ?? true
    }
}


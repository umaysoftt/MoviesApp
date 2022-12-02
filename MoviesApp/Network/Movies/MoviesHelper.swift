//
//  MoviesHelper.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation

enum MovieCategory {
    case upcoming
}

enum MoviesHelper: String {
    case upcoming = "movie/upcoming"

    var path: String {
        switch self {
        case .upcoming:
            return BaseHelper.shared.requestUrl(url: MoviesHelper.upcoming.rawValue)
        }
    }
}

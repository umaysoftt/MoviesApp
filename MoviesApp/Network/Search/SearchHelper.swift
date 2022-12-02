//
//  SearchHelper.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation

enum SearchEndpoint: String {
    case search = "search/movie"

    var path: String {
        switch self {
        case .search:
            return BaseHelper.shared.requestUrl(url: SearchEndpoint.search.rawValue)
        }
    }
}

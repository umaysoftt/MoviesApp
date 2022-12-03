//
//  MovieDetailHelper.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation

enum MovieDetailHelperEndpoint: String {
    case detail = "movie/"

    var path: String {
        switch self {
        case .detail:
            return BaseHelper.shared.requestUrl(url: MovieDetailHelperEndpoint.detail.rawValue)
        }
    }
}

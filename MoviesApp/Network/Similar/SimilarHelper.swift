//
//  SimilarHelper.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation

enum SimilarHelperHelperEndpoint: String {
    case similar = "movie/"

    var path: String {
        switch self {
        case .similar:
            return BaseHelper.shared.requestUrl(url: SimilarHelperHelperEndpoint.similar.rawValue)
        }
    }
}

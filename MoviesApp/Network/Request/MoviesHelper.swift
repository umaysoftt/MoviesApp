//
//  MoviesHelper.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation

final class MovieUpcomingRequest: BaseHelper {
    override init() {
        super.init()
        let apiKey = NetworkConstans.MovieServiceEndPoint.APIKEY.rawValue
        let lang = NetworkConstans.MovieServiceEndPoint.LANG.rawValue
        path = "upcoming?api_key=\(apiKey)\(lang)"
    }
}

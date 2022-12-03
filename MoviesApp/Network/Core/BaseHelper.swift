//
//  BaseHelper.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation
import Alamofire

enum ErrorTypes: String, Error {
    case invalidData = "Invalid data"
    case invalidURL = "Invalid url"
    case generalError = "An error happened"
}

class BaseHelper {

    var baseURL: String = NetworkConstans.MovieServiceEndPoint.BASEURL.rawValue
    var path: String?
    var method: HTTPMethod = .get

    var url: String {
        baseURL + path.orEmpty
    }
}


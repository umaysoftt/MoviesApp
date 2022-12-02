//
//  SearchManager.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import Foundation

protocol SearchManagerProtocol {
    func getSearchItems(text: String, page: Int, complete: @escaping((Movie?, Error?)->()))
}

class SearchManager: SearchManagerProtocol {
    static let shared = SearchManager()

    func getSearchItems(text: String, page: Int, complete: @escaping ((Movie?, Error?) -> ())) {
        BaseNetworkManager.shared.request(type: Movie.self,
                                      url: SearchEndpoint.search.path + "&query=\(text)&page=\(page)",
                                      method: .get) { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                complete(nil, error)
            }
        }
    }
}

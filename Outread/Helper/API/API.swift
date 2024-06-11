//
//  API.swift
//  Squeezee
//
//  Created by AKASH on 04/08/23.
//

import Foundation

// MARK: - API
enum API {
    case products(page: Int)
    case categories(perentID: Int?)
    case searchProduct(search: String)
}

// MARK: - APIProtocol
extension API: APIProtocol {
    var baseURL: String {
        "https://out-read.com/wp-json/wc/v3/"
    }
    
    var path: String {
        switch self {
        case .products:
            return "products"
        case .categories:
            return "products/categories"
        case .searchProduct:
            return "products"
        }
    }
    
    var method: APIMethod {
        switch self {
        case .products, .categories, .searchProduct:
            return .get
        }
    }
    
    var task: Request {
        switch self {
        case let .products(page):
            let params: [String: Any] = ["consumer_key": Globals.CONUMER_KEY,
                                         "consumer_secret": Globals.CONUMER_SECRET,
                                         "page": page,
                                         "per_page": 100]
            return .queryString(params)
        case let .categories(perentID):
            var params: [String: Any] = [:]
            if let perentID = perentID {
                params = ["consumer_key": Globals.CONUMER_KEY,
                          "consumer_secret": Globals.CONUMER_SECRET,
                          "parent": perentID,
                          "per_page": 100]
            } else {
                params = ["consumer_key": Globals.CONUMER_KEY,
                          "consumer_secret": Globals.CONUMER_SECRET,
                          "per_page": 100]
            }
            return .queryString(params)
        case let .searchProduct(search):
            let params: [String: Any] = ["consumer_key": Globals.CONUMER_KEY,
                                         "consumer_secret": Globals.CONUMER_SECRET,
                                         "search": search]
            return .queryString(params)
        }
    }
    
    var header: [String: String] {
        switch self {
        case .products, .categories, .searchProduct:
            return ["Content-Type": "application/json"]
        }
    }
}

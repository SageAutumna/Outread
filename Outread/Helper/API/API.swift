//
//  API.swift
//  Squeezee
//
//  Created by AKASH on 04/08/23.
//

import Foundation

// MARK: - API
enum API {
    case login(userName: String, password: String)
    case products(page: Int)
    case categories(perentID: Int?)
    case searchProduct(search: String)
    case article(name: String)
    case updateEmail(email: String)
}

// MARK: - APIProtocol
extension API: APIProtocol {
    var baseURL: String {
        switch self {
        case .updateEmail:
            return "https://yourapi.com/"
        default:
            return "https://out-read.com/wp-json/"
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "jwt-auth/v1/token"
        case .products:
            return "wc/v3/products"
        case .categories:
            return "wc/v3/products/categories"
        case .searchProduct:
            return "wc/v3/products"
        case .article:
            return "wp/v2/article"
        case .updateEmail:
            return "update-email"
        }
    }
    
    var method: APIMethod {
        switch self {
        case .products, .categories, .searchProduct, .article:
            return .get
        case .login, .updateEmail:
            return .post
        }
    }
    
    var task: Request {
        switch self {
        case let .login(userName, password):
            let params: [String: Any] = ["username": userName,
                                         "password": password]
            return .jsonEncoding(params)
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
        case let .article(name):
            let params: [String: Any] = ["search": name]
            return .queryString(params)
        case let .updateEmail(email):
            let params: [String: Any] = ["email": email]
            return .jsonEncoding(params)
        }
    }
    
    var header: [String: String] {
        switch self {
        case .login, .products, .categories, .searchProduct, .article, .updateEmail:
            return ["Content-Type": "application/json"]
        }
    }
}

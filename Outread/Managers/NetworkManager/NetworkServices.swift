//
//  NetworkServices.swift
//  Outread
//
//  Created by AKASH BOGHANI on 26/05/24.
//

import Foundation

protocol NetworkServices {
    func fetchAllProducts(page: Int) async throws -> [Product]
    
    func fetchCategories(excludingParentID parentID: Int) async throws -> [Category]
    
    func fetchPlayList() async throws -> [Playlist]
    
    func searchProduct(search: String) async throws -> [Product]
    
    func fetchArticleByTitle(name: String) async throws -> String?
}

class NetworkHandler: NetworkServices {
    func fetchAllProducts(page: Int) async throws -> [Product] {
        try await APIService.request(API.products(page: page))
    }
    
    func fetchCategories(excludingParentID parentID: Int) async throws -> [Category] {
        let categories: [Category] = try await APIService.request(API.categories(perentID: nil))
        return categories.filter { (($0.parent ?? -1) != parentID ) && !($0.colorCategory?.isEmpty ?? false) }
    }
    
    func fetchPlayList() async throws -> [Playlist] {
        try await APIService.request(API.categories(perentID: 134))
    }
    
    func searchProduct(search: String) async throws -> [Product] {
        try await APIService.request(API.searchProduct(search: search))
    }
    
    func fetchArticleByTitle(name: String) async throws -> String? {
        let model: [Article] = try await APIService.request(API.article(name: name))
        return model.first?.content.rendered
    }
}

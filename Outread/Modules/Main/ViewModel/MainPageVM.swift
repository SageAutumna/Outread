//
//  MainPageVM.swift
//  Outread
//
//  Created by AKASH BOGHANI on 09/06/24.
//

import SwiftUI

@MainActor
final class MainPageVM: ObservableObject {
    // MARK: - Properties
    @Published var featuredProduct: Product?
    @Published var products = [Product]()
    @Published var playLists = [Product]()
    @Published var categories = [Category]()
    private var isMoreProductAvailable = true
    private var productPage = 1
    private var taskDisposeBag = TaskBag()
    private let networkHandler: NetworkServices
    
    // MARK: - Life-Cycle
    init(networkHandler: NetworkServices = NetworkHandler()) {
        self.networkHandler = networkHandler
    }
    
    // MARK: - Functions
    func getAllData(complition: @escaping ([Product], [Category]) -> Void) {
        Task {
            do {
                async let categories = try networkHandler.fetchCategories(excludingParentID: 59)
                async let playList = try networkHandler.fetchPlayList()
                async let isLoadMoreData = try fetchAllProduct(page: productPage)
                
                self.categories = try await categories
                self.playLists = try await playList.map { list in
                    Product(id: list.id, name: list.name, images: [list.image], count: list.count)
                }
                self.isMoreProductAvailable = try await isLoadMoreData
                
                // Move categories to front if necessary
                self.categories = self.categories.moveToFront { $0.name?.uppercased() == "TRENDING" }
                self.categories = self.categories.moveToFront { $0.name?.uppercased() == "PLAYLIST" }
                complition(self.products, self.categories)
            } catch {
                handleError(error)
            }
        }.store(in: &taskDisposeBag)
    }
    
    func fetchAllProduct(page: Int) async throws -> Bool {
        let fetchedProducts = try await networkHandler.fetchAllProducts(page: page)
        guard !fetchedProducts.isEmpty else { return false }
        if page == 1 { products.removeAll() }
        products.append(contentsOf: fetchedProducts)
        featuredProduct = products.first { $0.categories?.contains { $0.name?.uppercased() == "FREE" } ?? false }
        return true
    }
    
    func getAllProduct(page: Int) async -> Bool {
        var isLoadMoreData = false
        do {
            isLoadMoreData = try await fetchAllProduct(page: page)
        } catch {
            handleError(error)
        }
        return isLoadMoreData
    }
    
    private func handleError(_ error: Error) {
        if let apiError = error as? APIError {
            UIApplication.keyWindow?.rootViewController?.showAlert(msg: apiError.description)
        } else {
            UIApplication.keyWindow?.rootViewController?.showAlert(msg: error.localizedDescription)
        }
    }
}



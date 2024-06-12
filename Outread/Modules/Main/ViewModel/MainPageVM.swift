//
//  MainPageVM.swift
//  Outread
//
//  Created by AKASH BOGHANI on 09/06/24.
//

import SwiftUI

@MainActor
final class MainPageVM: ObservableObject {
    //MARK: - Properties
    @Published var featuredProduct: Product?
    @Published var products = [Product]()
    @Published var playLists = [Product]()
    @Published var categories = [Category]()
    @Published var isLoading: Bool = false
    private var isMoreProductAvailable = true
    private var productPage = 1
    private var taskDisposeBag = TaskBag()
    private let networkHandler: NetworkServices
    
    //MARK: - Life-Cycle
    init(networkHandler: NetworkServices = NetworkHandler()) {
        self.networkHandler = networkHandler
    }
    
    //MARK: - Functions
    func filterProducts(for categoryName: String) -> [Product] {
        products.filter { product in
            product.categories?.contains(where: { $0.name.uppercased() == categoryName.uppercased() }) ?? false
        }
    }
    
    func handleOnAppear(for product: Product,categoryName:String) {
       let productList = filterProducts(for: categoryName)
        if isMoreProductAvailable && product.id == productList.last?.id {
            productPage += 1
            Task {
                isMoreProductAvailable = getAllProduct(page: productPage)
            }
        }
    }

    func getAllData() {
        isLoading = true
        Task {
            do {
                async let categories = try networkHandler.fetchCategories(excludingParentID: 59)
                async let playList = try networkHandler.fetchPlayList()
                async let isLoadMoreData = try fetchAllProduct(page: productPage)
                self.categories = try await categories
                self.categories = self.categories.moveToFront { $0.name.uppercased() == "trending".uppercased() }
                self.categories = self.categories.moveToFront { $0.name.uppercased() == "playlist".uppercased() }
                self.playLists = try await playList.map { list in
                    Product(id: list.id, name: list.name, images: [list.image], count: list.count)
                }
                self.isMoreProductAvailable = try await isLoadMoreData
            } catch let error as APIError {
                UIApplication.keyWindow?.rootViewController?.showAlert(msg: error.description)
            } catch {
                UIApplication.keyWindow?.rootViewController?.showAlert(msg: error.localizedDescription)
            }
            isLoading = false
        }.store(in: &taskDisposeBag)
    }
    
    func fetchAllProduct(page: Int) async throws -> Bool {
        let fetchedProducts = try await networkHandler.fetchAllProducts(page: page)
        guard !fetchedProducts.isEmpty else { return false }
        if page == 1 { products.removeAll() }
        products.append(contentsOf: fetchedProducts)
            featuredProduct = products.first { $0.categories?.contains { $0.name.uppercased() == "free".uppercased() } ?? false }
        return true
    }
    
    func getAllProduct(page: Int) -> Bool {
        isLoading = true
        var isLoadMoreData = false
        Task {
            do {
                isLoadMoreData = try await fetchAllProduct(page: page)
                
            } catch let error as APIError {
                UIApplication.keyWindow?.rootViewController?.showAlert(msg: error.description)
            } catch {
                UIApplication.keyWindow?.rootViewController?.showAlert(msg: error.localizedDescription)
            }
            isLoading = false
        }.store(in: &taskDisposeBag)
        return isLoadMoreData
    }
}

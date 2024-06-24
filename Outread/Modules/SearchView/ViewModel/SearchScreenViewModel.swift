//
//  SearchScreenViewModel.swift
//  Outread
//
//  Created by AKASH BOGHANI on 26/05/24.
//

import SwiftUI
import Combine

@MainActor
class SearchScreenViewModel: ObservableObject {
    //MARK: - Properties
    @Published var searchText: String = ""
    var product: [Product]?
    @Published var isLoading: Bool = false
    private var taskDisposeBag = TaskBag()
    private let networkHandler: NetworkServices
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Life-Cycle
    init(networkHandler: NetworkServices = NetworkHandler()) {
        self.networkHandler = networkHandler
    }
    
    //MARK: - Functions
    func setupDebounce() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] (searchText) in
                self?.fetchProduct(query: searchText)
            }
            .store(in: &cancellables)
    }
    
    private func fetchProduct(query: String) {
        isLoading = true
        Task {
            do {
                let responseModel = try await networkHandler.searchProduct(search: query)
                product = responseModel
                isLoading = false
            } catch let error as APIError {
                isLoading = false
                UIApplication.keyWindow?.rootViewController?.showAlert(msg: error.description)
            } catch {
                isLoading = false
                UIApplication.keyWindow?.rootViewController?.showAlert(msg: error.localizedDescription)
            }
        }.store(in: &taskDisposeBag)
    }
}

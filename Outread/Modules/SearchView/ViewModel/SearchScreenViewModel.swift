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
    func fetchProduct(query: String) {
        isLoading = true
        Task {
            do {
                let responseModel = try await networkHandler.searchProduct(search: query)
                product = responseModel
                isLoading = false
            } catch let error as APIError {
                isLoading = false
                Alert.shared.showAlert(msg: error.description)
            } catch {
                isLoading = false
                Alert.shared.showAlert(msg: error.localizedDescription)
            }
        }.store(in: &taskDisposeBag)
    }
}

//
//  LoginVm.swift
//  Outread
//
//  Created by AKASH BOGHANI on 21/06/24.
//

import SwiftUI

@MainActor
final class LoginVm: ObservableObject {
    //MARK: - Properties
    private var taskDisposeBag = TaskBag()
    private let networkHandler: NetworkServices
    
    //MARK: - Life-Cycle
    init(networkHandler: NetworkServices = NetworkHandler()) {
        self.networkHandler = networkHandler
    }
    
    //MARK: - Functions
    func authenticateUser(username: String, password: String, complition: @escaping () -> Void) {
        Task {
            do {
                _ = try await networkHandler.authenticate(username: username, password: password)
                complition()
            } catch {
                handleError(error)
            }
        }.store(in: &taskDisposeBag)
    }
    
    private func handleError(_ error: Error) {
        if let apiError = error as? APIError {
            Alert.shared.showAlert(msg: apiError.description)
        } else {
            Alert.shared.showAlert(msg: error.localizedDescription)
        }
    }
}

//
//  SignUpVm.swift
//  Outread
//
//  Created by iOS DEVELOPER on 07/07/24.
//

import SwiftUI

@MainActor
final class SignUpVm: ObservableObject {
    //MARK: - Properties
    private var taskDisposeBag = TaskBag()
    private let networkHandler: NetworkServices
    
    //MARK: - Life-Cycle
    init(networkHandler: NetworkServices = NetworkHandler()) {
        self.networkHandler = networkHandler
    }
    
    //MARK: - Functions
    func sinUpUser(model: SignUpModel, complition: @escaping () -> Void) {
        Task {
            do {
                _ = try await networkHandler.signUpUser(model: model)
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

//
//  UpdateEmailVm.swift
//  Outread
//
//  Created by AKASH BOGHANI on 23/06/24.
//

import SwiftUI

@MainActor
final class UpdateEmailVm: ObservableObject {
    //MARK: - Properties
    @Published var email: String = ""
    @Published var isLoading: Bool = false
    
    private var taskDisposeBag = TaskBag()
    private let networkHandler: NetworkServices
    
    //MARK: - Life-Cycle
    init(networkHandler: NetworkServices = NetworkHandler()) {
        self.networkHandler = networkHandler
    }
    
    //MARK: - Functions
    func updateEmail() {
        HapticManager.generateHapticFeedback(for: .impact(feedbackStyle: .light))
        guard !email.isEmpty else {
            Alert.shared.showAlert(msg: "Email cannot be empty.")
            return
        }
        isLoading = true
        Task {
            do {
                _ = try await networkHandler.updateEmail(email: email)
            } catch {
                handleError(error)
            }
        }.store(in: &taskDisposeBag)
        isLoading = false
    }
    
    private func handleError(_ error: Error) {
        if let apiError = error as? APIError {
            Alert.shared.showAlert(msg: apiError.description)
        } else {
            Alert.shared.showAlert(msg: error.localizedDescription)
        }
    }
}

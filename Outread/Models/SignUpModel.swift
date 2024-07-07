//
//  SignUpModel.swift
//  Outread
//
//  Created by iOS DEVELOPER on 07/07/24.
//

import Foundation

// MARK: - SignUpModel
struct SignUpModel: Codable {
    let username: String?
    let password: String?
    let email: String?
    let nickname: String?
    let last_name: String?
    let first_name: String?
    let phone_number: String?
}

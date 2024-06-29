//
//  AppRoutes.swift
//  SwiftUIDemo
//
//  Created by iOS Developer on 11/12/23.
//

import Foundation

// MARK: - AppRoute
enum AppRoutes: Equatable {
    case tab
    case explainer1
    case explainer2
    case login
    case main
    case articles(products: [Product], categoryName: String, playlists: [Product], categories: [Category])
    case categories(categories: [Category], products: [Product], playlists: [Product])
    case flashcardMain(product: Product, categories: [Category])
    case flashcard(productName: String)
    case updateEmail
    case privacyPolicy
}

//
//  OutreadApp.swift
//  Outread
//
//  Created by Dhruv Sirohi on 17/1/2024.
//

import SwiftUI
import SwiftData


@main
struct OutreadApp: App {
    // MARK: - Properties
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            LocalStorageData.self,
            LocalDataStorage.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    // MARK: - Life-Cycle
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            RouterHost(Router(initial: hasCompletedOnboarding ? AppRoutes.tab : AppRoutes.onboarding)) { route in
                switch route {
                case .onboarding: 
                    OnboardingView()
                case .tab:
                    MainTabView()
                case .main:
                    MainPageView()
                case let .articles(products, categoryName, playlists, categories):
                    ArticlesVIew(products: products, categoryName: categoryName, playlists: playlists, categories: categories)
                case let .categories(categories, products, playlists):
                    CategoriesView(categories: categories, products: products, playLists: playlists)
                case let .flashcardMain(product, categories):
                    FlashcardMainView(product: product, categories: categories)
                }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}

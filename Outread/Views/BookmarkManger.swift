import SwiftUI

class BookmarkManager: ObservableObject {
    // MARK: - Properties
    @Published var bookmarkedProductIds: Set<Int> = []

    // MARK: - Functions
    func isBookmarked(_ product: Product) -> Bool {
        bookmarkedProductIds.contains(product.id ?? 0)
    }

    func toggleBookmark(for product: Product) {
        if isBookmarked(product) {
            bookmarkedProductIds.remove(product.id ?? 0)
        } else {
            bookmarkedProductIds.insert(product.id ?? 0)
        }
    }
}

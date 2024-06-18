//
//  Category.swift
//  Outread
//
//  Created by Dhruv Sirohi on 2/4/2024.
//

import SwiftUI

struct CategoryView: View {
    //MARK: - Properties
    let category: Category
    var isViewAll = false
    var didTap: (() -> Void)
    
    //MARK: - Body
    var body: some View {
        Text(category.name ?? "")
            .frame(width: category.name?.lowercased() == "playlist" ? 0 : isViewAll ? (UIScreen.main.bounds.size.width - 120)/2 : 100 , height: 70)
            .foregroundColor(.white)
            .padding(.horizontal, category.name?.lowercased() == "playlist" ? 0 : 20)
            .background(Color(hex: category.colorCategory ?? ""))
            .clipShape(
                RoundedRectangle(cornerRadius: 13, style: .continuous)
            )
            .onTapGesture {
                didTap()
            }
    }
    
    //MARK: - Functions
}

struct CategoriesScrollView: View {
    //MARK: - Properties
    let categories: [Category]
    var products : [Product]
    var isNeedFilter = true
    var didTap: ((Int) -> Void)
    
    //MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(categories, id: \.id) { category in
                    if isNeedFilter {
                        if filterList(products, categoryName: category.name ?? "").count > 2 {
                            CategoryView(category: category) {
                                didTap(category.id ?? 0)
                            }
                        }
                    } else {
                        CategoryView(category: category) {
                            didTap(category.id ?? 0)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    //MARK: - Functions
    func filterList(_ list: [Product], categoryName: String) -> [Product] {
        return list
            .filter { $0.categories?.count ?? 0 > 0 }
            .filter{ $0.categories?.contains { cat in cat.name?.lowercased() == categoryName.lowercased() } ?? false }
    }
}

struct Category: Identifiable, Codable, Equatable {
    var id: Int?
    var name: String?
    var parent: Int?
    var colorCategory : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case parent
        case colorCategory = "color_category"
    }
}

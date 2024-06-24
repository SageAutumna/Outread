//
//  Category.swift
//  Outread
//
//  Created by Dhruv Sirohi on 2/4/2024.
//

import SwiftUI

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

struct CategoryView: View {
    //MARK: - Properties
    let category: Category
    var isViewAll = false
    var didTap: (() -> Void)
    
    //MARK: - Body
    var body: some View {
        Text(category.name ?? "")
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .font(.poppins(weight: .medium, size: 19))
            .padding(.horizontal, category.name?.lowercased() == "playlist" ? 0 : 24)
            .padding(.vertical, 20)
            .background(Color(hex: category.colorCategory ?? ""))
            .clipShape(RoundedRectangle(cornerRadius: 13))
            .onTapGesture {
                didTap()
            }
    }
    
    //MARK: - Functions
}

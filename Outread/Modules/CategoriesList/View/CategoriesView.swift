//
//  CategoriesView.swift
//  Outread
//
//  Created by Jaspreet Singh on 24/05/24.
//

import SwiftUI

struct CategoriesView: View {
    //MARK: - Properties
    @EnvironmentObject private var router: Router<AppRoutes>
    
    @State var selectedCategoryName = ""
    
    var categories : [Category]
    var products : [Product]
    var playLists : [Product]
    var hGridColumns = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(categories: [Category], products: [Product], playLists: [Product]) {
        self.categories = categories
        self.products = products
        self.playLists = playLists
        self.categories.removeAll { cat in cat.name?.lowercased() == "playlist" }
    }
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.COLOR_141_D_2_A.edgesIgnoringSafeArea(.all)
            
            VStack {
                makeNavBar(title: "Categories") {
                    router.pop()
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        showCategories
                    }
                }
            }
        }
    }
    
    private var showCategories: some View{
        VStack {
            LazyVGrid(columns: hGridColumns, spacing: 15) {
                ForEach(categories, id: \.id) { category in
                    Text(category.name ?? "")
                        .frame(width: (UIScreen.main.bounds.size.width - 45) / 2, height: 70)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .font(.poppins(weight: .medium, size: 19))
                        .background(Color(hex: category.colorCategory ?? ""))
                        .clipShape(RoundedRectangle(cornerRadius: 13))
                        .onTapGesture {
                            let filterData = categories.filter { $0.id == category.id }
                            selectedCategoryName = !filterData.isEmpty ? filterData.first?.name ?? "" : ""
                            router.push(.articles(products: products, categoryName: selectedCategoryName, playlists: playLists, categories: categories))
                        }
                }
            }
            .padding(.horizontal, 15)
        }
        .padding(.top, 10)
    }
    
    //MARK: - Functions
}



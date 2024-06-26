//
//  CategoriesView.swift
//  Outread
//
//  Created by Jaspreet Singh on 24/05/24.
//

import SwiftUI

struct CategoriesView: View {
    var categories : [Category]
    var products : [Product]
    var playLists : [Product]
    var hGridColumns = [
        GridItem(.fixed((UIScreen.main.bounds.size.width - 30)/2)),
        GridItem(.fixed((UIScreen.main.bounds.size.width - 30)/2))
    ]
    @State var selectedCategoryName = ""
    @State private var pressViewAll = false
    let backgroundColor = Color(red: 0x11 / 255.0, green: 0x1E / 255.0, blue: 0x2B / 255.0)
    @State var showNavigation = true
    
    init(categories: [Category], products: [Product], playLists: [Product], hGridColumns: [GridItem] = [
        GridItem(.fixed((UIScreen.main.bounds.size.width - 30)/2)),
        GridItem(.fixed((UIScreen.main.bounds.size.width - 30)/2))
    ], selectedCategoryName: String = "", pressViewAll: Bool = false, showNavigation: Bool = true) {
        self.categories = categories
        self.products = products
        self.playLists = playLists
        self.hGridColumns = hGridColumns
        self.selectedCategoryName = selectedCategoryName
        self.pressViewAll = pressViewAll
        self.showNavigation = showNavigation
        self.categories.removeAll { cat in
            cat.name.lowercased() == "playlist"
        }
    }
    
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            ZStack {
                NavigationLink(destination: ArticlesVIew(products: products, categoryName: selectedCategoryName, playlists: playLists, categories: categories) .navigationTitle(selectedCategoryName).navigationBarColor(backgroundColor: .clear, titleColor: .white), isActive: $pressViewAll) {
                    Text("")
                }.hidden()
                ScrollView {
                    VStack(alignment: .leading) {
                        showCategories()
                    }
                }.padding(.top,15)
            }
        }
    }
    
    
    private func showCategories() -> some View{
        VStack {
            LazyVGrid(columns: hGridColumns,spacing: 15) {
                ForEach(categories) { category in
                    CategoryView(category: category, isViewAll: true) {
                        let filterData = categories.filter{ $0.id == category.id }
                        selectedCategoryName = !filterData.isEmpty ? filterData.first?.name ?? "" : ""
                        pressViewAll = true
                    }
                }
                .padding([.leading,.trailing],15)
            }
        }
        .padding(.top,10)
    }
}

struct NavigationBarModifier: ViewModifier {
    
    var backgroundColor: UIColor?
    var titleColor: UIColor?
    
    init(backgroundColor: UIColor?, titleColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}
extension View {
    
    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }
    
}

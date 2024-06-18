import SwiftUI
import SwiftData
import UIKit

struct MainPageView: View {
    // MARK: - Properties
    @EnvironmentObject private var router: Router<AppRoutes>
    @ObservedObject private var viewModel = MainPageVM()
    @Query var bookmarksList: [LocalDataStorage]
    @Query var products: [LocalProduct]
    @Query var categories: [LocalCategory]
    @Environment(\.modelContext) var context
    @State private var selectedCategoryName = ""
    
    @State private var tempProducts: [Product] = []
    @State private var tempCats: [Category] = []
    
    var grid: [GridItem] = [GridItem(.flexible())]
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.COLOR_141_D_2_A.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    headerView
                    featuredArticleSection
                    categoriesSection
                    setProductHeader()
                }
            }
            .padding(.top, 15)
            .padding(.bottom, ((UIApplication.keyWindow?.safeAreaInsets.bottom ?? 0) + 35))
        }
        .onAppear {
            getLocalData {
                self.getRemoteData()
            }
        }
    }
    
    var headerView: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Home")
                        .foregroundColor(.white)
                        .font(.poppins(weight: .medium, size: 36))
                    
                    Rectangle()
                        .frame(height: 4)
                        .foregroundColor(Color.COLOR_9178_A_8)
                }
                
                Spacer()
                    .frame(maxWidth: .infinity)
            }
            
            if let _ = viewModel.featuredProduct {
                Text("Featured Read of the Day")
                    .font(.poppins(weight: .medium, size: 18))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 15)
    }
    
    var featuredArticleSection: some View {
        Group {
            if let featuredProduct = viewModel.featuredProduct {
                let imageURL = featuredProduct.metaData?.first(where: { $0.key == "image_url" })?.value ?? (featuredProduct.images?.first?.src ?? "")
                let readingTime = featuredProduct.metaData?.first(where: { $0.key == "reading-time" })?.value ?? "0 min"
                
                FeatureTopArticle(image: imageURL, title: featuredProduct.name ?? "", duration: "\(readingTime) mins", product: featuredProduct, didBookmark: bookmarkProduct)
                    .onTapGesture {
                        router.push(.flashcardMain(product: featuredProduct, categories: tempCats))
                    }
                    .padding(.bottom, 10)
            }
        }
    }
    
    var categoriesSection: some View {
        VStack(alignment: .leading) {
            CategoryHeader(title: "Categories") {
                router.push(.categories(categories: tempCats, products: tempProducts, playlists: viewModel.playLists))
            }
            
            CategoriesScrollView(categories: tempCats, products: tempProducts) { id in
                if let selectedCategory = tempCats.first(where: { $0.id == id }) {
                    selectedCategoryName = selectedCategory.name ?? ""
                    router.push(.articles(products: tempProducts, categoryName: selectedCategoryName, playlists: viewModel.playLists, categories: tempCats))
                }
            }
        }
    }
    
    func setProductHeader() -> some View {
        VStack {
            ForEach(tempCats, id: \.id) { category in
                CategoryHeader(title: category.name ?? "") {
                    selectedCategoryName = category.name ?? ""
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    showProductHGrid(category.name ?? "", products: filterTempProducts(for: category.name ?? ""))
                }
            }
        }
    }
    
    func productNavigationLink(for product: Product, categoryName: String) -> some View {
        ProductRow(product: product, boormark: bookmarkProduct)
            .frame(width: categoryName.lowercased() == "playlist" ? ((UIScreen.main.bounds.size.width - 45) / 2) * 1.3 : ((UIScreen.main.bounds.size.width - 45) / 2))
            .onTapGesture {
                router.push(.flashcardMain(product: product, categories: tempCats))
            }
    }
    
    func showProductHGrid(_ categoryName: String, products: [Product]) -> some View {
        LazyHGrid(rows: grid, alignment: .firstTextBaseline, spacing: 15) {
            ForEach(products) { product in
                productNavigationLink(for: product, categoryName: categoryName)
            }
        }
        .padding(.horizontal, 15)
    }
    
    // MARK: - Methods
    func getRemoteData() {
        if products.isEmpty {
            self.viewModel.getAllData { products, categories in
                for product in products {
                    self.saveProduct(product)
                }
                for category in categories {
                    self.saveCategory(category)
                }
                self.tempProducts = products
                self.tempCats = categories
            }
        }
    }
    
    func getLocalData(completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        tempProducts = products.map { localProduct in
            Product(id: localProduct.id, name: localProduct.name, permalink: localProduct.permalink, desc: localProduct.desc, shortDescription: localProduct.shortDescription, status: localProduct.status, price: localProduct.status, categories: localProduct.categories, images: localProduct.images, metaData: localProduct.metaData, count: localProduct.count)
        }
        dispatchGroup.leave()
        
        dispatchGroup.enter()
        tempCats = categories.map { localCategory in
            Category(id: localCategory.id, name: localCategory.name, parent: localCategory.parent, colorCategory: localCategory.colorCategory)
        }
        dispatchGroup.leave()
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    func bookmarkProduct(_ product: Product) {
        let item = LocalDataStorage(id: product.id ?? 0, name: product.name ?? "", shortDescription: product.shortDescription ?? "", categories: product.categories ?? [], images: product.images ?? [], metaData: product.metaData ?? [], descData: product.desc ?? "")
        
        if let existingIndex = bookmarksList.firstIndex(where: { $0.id == item.id }) {
            context.delete(bookmarksList[existingIndex])
        } else {
            context.insert(item)
        }
        
        do {
            try context.save()
        } catch {
            UIApplication.keyWindow?.rootViewController?.showAlert(msg: error.localizedDescription)
        }
    }
    
    func filterTempProducts(for categoryName: String) -> [Product] {
        tempProducts.filter { product in
            product.categories?.contains(where: { $0.name?.uppercased() == categoryName.uppercased() }) ?? false
        }
    }
    
    func saveProduct(_ product: Product) {
        let item = LocalProduct(id: product.id ?? 0, name: product.name ?? "", permalink: product.permalink ?? "", desc: product.desc ?? "", shortDescription: product.shortDescription ?? "", status: product.status ?? "", price: product.price ?? "", categories: product.categories ?? [], images: product.images ?? [], metaData: product.metaData ?? [], count: product.count ?? 0)
        
        if let existingIndex = products.firstIndex(where: { $0.id == item.id }) {
            context.delete(products[existingIndex])
        } else {
            context.insert(item)
        }
        
        do {
            try context.save()
        } catch {
            UIApplication.keyWindow?.rootViewController?.showAlert(msg: error.localizedDescription)
        }
    }
    
    func saveCategory(_ cat: Category) {
        let item = LocalCategory(id: cat.id ?? 0, name: cat.name ?? "", parent: cat.parent, colorCategory: cat.colorCategory ?? "")
        
        if let existingIndex = categories.firstIndex(where: { $0.id == item.id }) {
            context.delete(categories[existingIndex])
        } else {
            context.insert(item)
        }
        
        do {
            try context.save()
        } catch {
            UIApplication.keyWindow?.rootViewController?.showAlert(msg: error.localizedDescription)
        }
    }
}


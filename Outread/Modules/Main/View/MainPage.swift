import SwiftUI
import SwiftData

struct MainPageView: View {
    // MARK: - Properties
    @EnvironmentObject private var router: Router<AppRoutes>
    @ObservedObject private var viewModel = MainPageVM()
    @Query var bookmarksList: [LocalDataStorage]
    @Environment(\.modelContext) var context
    @State private var selectedCategoryName = ""
    
    var grid: [GridItem] = [GridItem(.flexible())]
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.COLOR_141_D_2_A.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading) {
                    headerView
                    featuredArticleSection
                    categoriesSection
                    setProductHeader()
                }
            }
            .padding(.top, 15)
            .padding(.bottom, ((UIApplication.keyWindow?.safeAreaInsets.bottom ?? 0) + 35))
            
            hud(isLoading: $viewModel.isLoading)
        }
        .task {
            if viewModel.categories.isEmpty {
                viewModel.getAllData()
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
                        router.push(.flashcardMain(product: featuredProduct, categories: viewModel.categories))
                    }
                    .padding(.bottom, 10)
            }
        }
    }
    
    var categoriesSection: some View {
        VStack(alignment: .leading) {
            if !viewModel.categories.isEmpty {
                CategoryHeader(title: "Categories") {
                    router.push(.categories(categories: viewModel.categories, products: viewModel.products, playlists: viewModel.playLists))
                }
                
                CategoriesScrollView(categories: viewModel.categories, products: viewModel.products) { id in
                    if let selectedCategory = viewModel.categories.first(where: { $0.id == id }) {
                        selectedCategoryName = selectedCategory.name
                        router.push(.articles(products: viewModel.products, categoryName: selectedCategoryName, playlists: viewModel.playLists, categories: viewModel.categories))
                    }
                }
            }
        }
    }
    
    func setProductHeader() -> some View {
        LazyVStack {
            ForEach(viewModel.categories, id: \.id) { category in
                if viewModel.filterProducts(for: category.name).count > 2 {
                    CategoryHeader(title: category.name) {
                        selectedCategoryName = category.name
                    }
                    
                    ScrollView(.horizontal) {
                        showProductHGrid(category.name, products: viewModel.filterProducts(for: category.name))
                    }
                }
            }
        }
    }
    
    func productNavigationLink(for product: Product, categoryName: String) -> some View {
        ProductRow(product: product, articleType: categoryName.lowercased() == "playlist" ? .playlist : .other, boormark: bookmarkProduct)
            .frame(width: categoryName.lowercased() == "playlist" ? ((UIScreen.main.bounds.size.width - 45) / 2) * 1.3 : ((UIScreen.main.bounds.size.width - 45) / 2))
//            .padding(.leading, 8)
            .onAppear {
                viewModel.handleOnAppear(for: product, categoryName: categoryName)
            }
            .onTapGesture {
                router.push(.flashcardMain(product: product, categories: viewModel.categories))
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
}


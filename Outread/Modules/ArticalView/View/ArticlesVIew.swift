
import SwiftUI
import SwiftData

struct ArticlesVIew: View {
    //MARK: - Properties
    @EnvironmentObject private var router: Router<AppRoutes>
    @Environment(\.modelContext) var context
    
    @Query var bookmarksList: [LocalDataStorage]
    
    @State var hGridColumns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var products: [Product]
    var categoryName: String
    var playlists: [Product]
    var categories: [Category]
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.COLOR_141_D_2_A.edgesIgnoringSafeArea(.all)
            
            VStack {
                makeNavBar(title: categoryName) {
                    router.pop()
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        showArticles
                    }
                }
            }
        }
    }
    
    private var showArticles: some View{
        VStack {
            LazyVGrid(columns: hGridColumns, spacing: 10) {
                ForEach(categoryName.lowercased() == "playlist" ? playlists : filterList(products, categoryName: categoryName)) { product in
                    ProductRow(product: product) { bookProduct in
                        bookMarkProduct(bookProduct: bookProduct)
                    }
                    .frame(width: (UIScreen.main.bounds.size.width - 45) / 2)
                    .onTapGesture {
                        router.push(.flashcardMain(product: product, categories: categories))
                    }
                }
            }
            .padding(.horizontal, 15)
        }
    }
    
    //MARK: - Functions
    private func filterList(_ list:[Product],categoryName:String) -> [Product]{
        return list
            .filter { $0.categories?.count ?? 0 > 0 }
            .filter { $0.categories?.contains { cat in cat.name?.lowercased() == categoryName.lowercased() } ?? false }
    }
    
    private func bookMarkProduct(bookProduct: Product) {
        let item = LocalDataStorage.init(id: bookProduct.id ?? 0, name: bookProduct.name ?? "", shortDescription: bookProduct.shortDescription ?? "", categories: bookProduct.categories ?? [], images: bookProduct.images ?? [], metaData: bookProduct.metaData ?? [],descData:bookProduct.desc ?? "")
        let filter = bookmarksList.filter{ $0.id == item.id }
        
        if !filter.isEmpty {
            let index = bookmarksList.firstIndex{$0.id == item.id}
            context.delete(bookmarksList[index ?? -1])
        } else {
            context.insert(item)
        }
        
        do {
            try context.save()
        } catch {
            print("save error----\(error.localizedDescription)")
        }
    }
}

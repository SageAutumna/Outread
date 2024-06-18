
import SwiftUI
import SwiftData
struct ArticlesVIew: View {
    
    var products : [Product]
    var categoryName:String
    var playlists : [Product]
    var categories : [Category]
    @Query var bookmarksList: [LocalDataStorage]
    @Environment(\.modelContext) var context
    @State var hGridColumns = [
        GridItem(.fixed((UIScreen.main.bounds.size.width - 30)/2)),
        GridItem(.fixed((UIScreen.main.bounds.size.width - 30)/2))
    ]
    
    let backgroundColor = Color(red: 0x11 / 255.0, green: 0x1E / 255.0, blue: 0x2B / 255.0)
    
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        showArticles()
                    }
                }.padding(.top,15)
            }
        }.onAppear {
            if categoryName.lowercased() == "playlist" {
                hGridColumns = [
                    GridItem(.fixed((UIScreen.main.bounds.size.width - 30))),
                ]
            } else {
                hGridColumns = [
                    GridItem(.fixed((UIScreen.main.bounds.size.width - 30)/2)),
                    GridItem(.fixed((UIScreen.main.bounds.size.width - 30)/2))
                ]
            }
        }
    }
    
    
    private func showArticles() -> some View{
        VStack() {
            LazyVGrid(columns: hGridColumns, spacing: 10) {
                ForEach(categoryName.lowercased() == "playlist" ? playlists : filterList(products, categoryName: categoryName)) { product in
                    NavigationLink(destination: FlashcardMainView(product: product, categories: categories).navigationBarHidden(true)) {
                        ProductRow(product: product) { bookProduct in
                            let item = LocalDataStorage.init(id: bookProduct.id ?? 0, name: bookProduct.name ?? "", shortDescription: bookProduct.shortDescription ?? "", categories: bookProduct.categories ?? [], images: bookProduct.images ?? [], metaData: bookProduct.metaData ?? [],descData:bookProduct.desc ?? "")
                            
                            let filter = bookmarksList.filter{$0.id == item.id}
                            
                            if filter.count > 0 {
                                
                                let index = bookmarksList.firstIndex{$0.id == item.id}
                                context.delete(bookmarksList[index ?? -1])
                            } else {
                                context.insert(item)
                            }
                            do {
                                try context.save()
                                print("saved successfully")
                            } catch {
                                print("save error----\(error)")
                            }
                        }
                        .padding(.trailing,15)
                    }
                }
            }
        }.padding(.top,10)
    }
    
    
    
    
    func filterList(_ list:[Product],categoryName:String) -> [Product]{
        return list.filter{$0.categories?.count ?? 0 > 0}.filter{$0.categories?.contains { cat in
            cat.name?.lowercased() == categoryName.lowercased()
        } ?? false }
    }
}

//#Preview {
//    ArticlesVIew()
//}

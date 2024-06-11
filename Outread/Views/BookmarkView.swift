//
//  BookmarkView.swift
//  Outread
//
//  Created by Dhruv Sirohi on 2/4/2024.
//

import SwiftUI
import SwiftData

//struct BookmarkView: View {
//    @EnvironmentObject var bookmarkManager: BookmarkManager
//    var products: [Product] // This should be passed from the main content view
//
//    var body: some View {
//        List(filteredProducts(), id: \.id) { product in
//            ProductRow(product: product, articleType: .other, boormark: {bookProduct in})
//        }
//        .navigationTitle("Bookmarks")
//    }
//    
//    private func filteredProducts() -> [Product] {
//        products.filter { bookmarkManager.isBookmarked($0) }
//    }
//}


struct BookmarkView : View{
    
    @Query var bookmarksList: [LocalDataStorage]
    @Environment(\.modelContext) var context
   @State var hGridColumns = [
        GridItem(.fixed((UIScreen.main.bounds.size.width - 30)/2)),
        GridItem(.fixed((UIScreen.main.bounds.size.width - 30)/2))
    ]
    
    let backgroundColor = Color(red: 0x11 / 255.0, green: 0x1E / 255.0, blue: 0x2B / 255.0)
    
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor.edgesIgnoringSafeArea(.all)
                ZStack {
                    ScrollView {
                        VStack(alignment: .center) {
                            headerView
                                showArticles()
                            ZStack(alignment: .center) {
                                    if bookmarksList.isEmpty {
                                        VStack(alignment: .center) {
                                            Text("").frame(height: 300)
                                            noProductFound
                                        }
                                    }
                                }
                        }
                    }.padding(.top,15)
                }
            }.onAppear {
                hGridColumns = [
                    GridItem(.fixed((UIScreen.main.bounds.size.width - 30)/2)),
                    GridItem(.fixed((UIScreen.main.bounds.size.width - 30)/2))
                ]
            }
        }
    }
    
    
    private func showArticles() -> some View{
        VStack() {
            LazyVGrid(columns: hGridColumns,spacing: 10){
                ForEach(bookmarksList) { product in
                    let cat = [Category]()
                    let newProduct = Product(id: product.id, name: product.name, permalink: "", desc: product.descData, shortDescription: product.shortDescription, status: "", price: "", categories: product.categories, images: product.images, metaData: product.metaData)
                    NavigationLink(destination: FlashcardMainView(product: newProduct, categories: cat).navigationBarTitle("Article Detail", displayMode: .inline)) {
                        ProductRow(product: newProduct, articleType: .other,isArticlesList: true,playlistWidth: .zero, playlistHeight:.zero, boormark: {bookProduct in
                            
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
                            
                        })
                            .padding(.trailing,15)
                        // .frame(width: (UIScreen.main.bounds.size.width/2))
                    }
                }
            }
        }.padding(.top,10)
    }
    
    
    var headerView: some View {
        VStack(alignment: .leading) {
            Text("Bookmarks")
                .foregroundColor(.white)
                .font(.custom("Poppins-Medium", size: 36))
                .padding(.top, 8)
                .padding(.bottom, -4)
            
            Rectangle()
                .frame(height: 4)
                .foregroundColor(Color(red: 170 / 255.0, green: 50 / 255.0, blue: 200 / 255.0))
                .padding(.trailing, 180)
        }
        .padding(.horizontal, 15)
    }
    
    var noProductFound: some View {
        VStack(alignment: .center) {
                Text("No Product Found")
                .frame(alignment: .center)
                .multilineTextAlignment(.center)
                    .font(.custom("Poppins-Medium", size: 20))
                    .foregroundColor(.white)
        }.padding([.leading,.trailing],15)
    }
    
    
    
    
    func filterList(_ list:[Product],categoryName:String) -> [Product]{
        return list.filter{$0.categories?.count ?? 0 > 0}.filter{$0.categories?.contains { cat in
            cat.name.lowercased() == categoryName.lowercased()
        } ?? false }
    }
}

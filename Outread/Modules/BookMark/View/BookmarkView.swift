//
//  BookmarkView.swift
//  Outread
//
//  Created by Dhruv Sirohi on 2/4/2024.
//

import SwiftUI
import SwiftData

struct BookmarkView : View{
    //MARK: - Properties
    @EnvironmentObject private var router: Router<AppRoutes>
    @Environment(\.modelContext) var context
    
    @Query var bookmarksList: [LocalDataStorage]
    
    @State var hGridColumns = [GridItem(.flexible()), GridItem(.flexible())]
        
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.COLOR_141_D_2_A.edgesIgnoringSafeArea(.all)
            
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        headerView
                        
                        showArticles
                        
                        ZStack(alignment: .center) {
                            if bookmarksList.isEmpty {
                                VStack(alignment: .center) {
                                    Spacer()
                                    
                                    Text("No Product Found")
                                        .frame(alignment: .center)
                                        .multilineTextAlignment(.center)
                                        .font(.poppins(weight: .medium, size: 20))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 15)
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(.bottom, ((UIApplication.keyWindow?.safeAreaInsets.bottom ?? 0) + 35))
                }
                .padding(.top, 15)
            }
        }
    }
    
    
    private var showArticles: some View{
        VStack {
            LazyVGrid(columns: hGridColumns, spacing: 10) {
                ForEach(bookmarksList, id: \.id) { product in
                    let newProduct = Product(id: product.id, name: product.name, permalink: "", desc: product.descData, shortDescription: product.shortDescription, status: "", price: "", categories: product.categories, images: product.images, metaData: product.metaData)
                    ProductRow(product: newProduct) { bookProduct in
                        bookMarkProduct(bookProduct: bookProduct)
                    }
                    .frame(width: (UIScreen.main.bounds.size.width - 45) / 2)
                    .onTapGesture {
                        router.push(.flashcardMain(product: newProduct, categories: []))
                    }
                }
            }
            .padding(.horizontal, 15)
        }
        .padding(.top, 15)
    }
    
    var headerView: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Bookmarks")
                        .foregroundColor(.white)
                        .font(.poppins(weight: .medium, size: 36))
                    
                    Rectangle()
                        .frame(height: 4)
                        .foregroundColor(Color.COLOR_9178_A_8)
                }
                .frame(width: 210.asDeviceWidth)
            }
        }
        .padding(.horizontal, 15)
    }
    
    //MARK: - Functions
    private func bookMarkProduct(bookProduct: Product) {
        let item = LocalDataStorage.init(id: bookProduct.id ?? 0, name: bookProduct.name ?? "", shortDescription: bookProduct.shortDescription ?? "", categories: bookProduct.categories ?? [], images: bookProduct.images ?? [], metaData: bookProduct.metaData ?? [],descData:bookProduct.desc ?? "")
        
        let filter = bookmarksList.filter{$0.id == item.id}
        
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

//
//  FlashcardView.swift
//  Outread
//
//  Created by Jaspreet Singh on 30/05/24.
//

import SwiftUI
import SwiftData

struct FlashcardMainView: View {
    //MARK: - Properties
    @EnvironmentObject private var router: Router<AppRoutes>
    @ObservedObject private var viewModel = FlashcardMainVm()
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @State private var isShowCategory = false
    @State private var categoriesList = [Category]()
    
    @State var product: Product
    @Query var bookmarksList: [LocalDataStorage]
    
    var categories: [Category]
    var width: CGFloat {
        (UIScreen.main.bounds.size.width - 45) / 2
    }
    var height: CGFloat {
        width * 1.3
    }
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.COLOR_141_D_2_A.edgesIgnoringSafeArea(.all)
            
            content
                .gesture(dragGesture)
                .onAppear(perform: setUI)
        }
    }
    
    private var content: some View {
        ZStack {
            Color(.COLOR_27394_F)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
            
            ZStack {
                ScrollView(showsIndicators: false) {
                    ZStack {
                        VStack(alignment: .leading, spacing: 8) {
                            if isShowCategory {
                                showTopView
                                    .padding(.bottom, 15)
                                
                                Text(product.name ?? "")
                                    .font(.poppins(weight: .medium, size: 22))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 15)
                                
                                Text(product.shortDescription?.htmlToString ?? "")
                                    .font(.poppins(weight: .regular, size: 17))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 15)
                                    .padding(.bottom, -15)
                                
                                addLine
                                
                                readingTime
                                
                                addLine
                                
                                Text(product.desc?.htmlToString ?? "")
                                    .font(.poppins(weight: .medium, size: 17))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 15)
                                
                                CategoriesScrollView(categories: categoriesList.filter{ $0.colorCategory != "" },
                                                     products: [product],
                                                     isNeedFilter: false) { id in }
                                    .padding(.bottom, 15)
                            }
                        }
                        .padding(.horizontal, 15)
                    }
                }
            }
            .padding(.vertical, 15)
        }
    }
    
    private var showTopView : some View {
        HStack(alignment: .top) {
            Spacer()
            
            kfImage(from: URL(string: product.images?.first?.src ?? ""))
                .aspectRatio(0.8, contentMode: .fill)
                .frame(width:width, height: height, alignment: .center)
                .cornerRadius(8)
            
            Spacer()
        }
        .overlay {
            bookmarks
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
    }
    
    private var bookmarks: some View {
        ZStack {
            let item = LocalDataStorage(id: product.id ?? 0,
                                        name: product.name ?? "",
                                        shortDescription: product.shortDescription ?? "",
                                        categories: product.categories ?? [],
                                        images: product.images ?? [],
                                        metaData: product.metaData ?? [],
                                        descData:product.desc ?? "")
            
            let filter = bookmarksList.filter{ $0.id == item.id }
            
            if filter.isEmpty {
                Image(.icBookmark)
                    .resizable()
                    .frame(width: 22, height: 28)
                    .foregroundColor(.white)
                    .padding(.trailing, 15)
                    .onTapGesture(perform: toggleBookmark)
            } else {
                Image(systemName: "bookmark.fill")
                    .resizable()
                    .frame(width: 22, height: 28)
                    .foregroundColor(.white)
                    .padding(.trailing, 15)
                    .onTapGesture(perform: toggleBookmark)
            }
        }
    }
    
    var addLine: some View {
        VStack {
            Rectangle()
                .frame(height: 1, alignment: .center)
                .foregroundColor(Color.white)
                .padding(.horizontal, 15)
        }
    }
    
    var readingTime: some View {
        HStack(spacing: 0) {
            let duration = product.metaData?.filter{$0.key == "reading-time"}
            let readingTime = (duration?.isEmpty ?? false ? "0 min" : "\(duration?.first?.value ?? "") mins")
            
            Image(.icReadingTime)
                .frame(width: 20, height: 20, alignment: .leading)
                .padding(.leading, 15)
                .padding(.top, -2)
            
            Text(readingTime)
                .font(.custom("Poppins-Regular", size: 17))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 15)
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onEnded { value in
                switch (value.translation.width, value.translation.height) {
                case (...0, -30...30):
                    router.push(.flashcard(productName: product.name ?? "", list: viewModel.list))
                case (0..., -30...30):
                    dismiss()
                default:
                    break
                }
            }
    }
    
    //MARK: - Functions
    private func setUI() {
        viewModel.loadArticle(name: product.name ?? "")
        showCategery()
    }
    
    private func showCategery() {
        for i in 0..<(product.categories?.count ?? 0) {
            let filter = categories.filter{ $0.name?.lowercased() == product.categories?[i].name?.lowercased() }
            if !filter.isEmpty {
                categoriesList.append(filter.first!)
            } else {
                if let category = product.categories?[i] {
                    categoriesList.append(category)
                }
            }
            if i == (product.categories?.count ?? 0) - 1 {
                isShowCategory = true
            }
        }
    }
    
    private func toggleBookmark() {
        let item = LocalDataStorage(
            id: product.id ?? 0,
            name: product.name ?? "",
            shortDescription: product.shortDescription ?? "",
            categories: product.categories ?? [],
            images: product.images ?? [],
            metaData: product.metaData ?? [],
            descData: product.desc ?? ""
        )
        
        if let index = bookmarksList.firstIndex(where: { $0.id == item.id }) {
            context.delete(bookmarksList[index])
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

struct ListType: Codable, Equatable {
    var str1: String
    var str2: String
}
